//
//  ViewController.swift
//  MyMovies
//
//  Created by Adnan Joraid on 2022-07-16.
//

import UIKit

class MoviesVC: UIViewController {
    
    enum Section {
        case main
    }
    
    var movies: [Movie] = []
    var filteredMovies = [Movie]()
    var movieCTA: MovieDetails? = nil
    var isSearching: Bool = false
    var isLoading: Bool = false
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Movie>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMovies()
        configureCollectionView()
        configureDataSource()
        configureSearchController()
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createTwoColumnFlowLayout())
        view.addSubview(collectionView)
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseID)
        collectionView.delegate = self
    }
    
    
    func getMovies() {
        NetworkManager.shared.getTopMovies { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movies):
                self.movies = movies.items
                self.updateData(on: self.movies)
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a movie"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        
    }
    
    private func createTwoColumnFlowLayout() -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 8
        let minimumItemSpacing: CGFloat = 8
        let availableWidth = width - (padding * 3) - (minimumItemSpacing * 3)
        let itemWidth = availableWidth / 2
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 60)
        
        return flowLayout
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Movie>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, movie) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseID, for: indexPath) as! MovieCell
            cell.set(movie: movie)
            return cell
        })
    }
    
    func updateData(on movies: [Movie]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
        snapshot.appendSections([.main])
        snapshot.appendItems(movies)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }

}

//MARK: - Extensions

extension MoviesVC: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        isLoading = true
        let activeArray = isSearching ? filteredMovies : movies
        let movie = activeArray[indexPath.item]

        
        let destVC = MovieDetailsVC(movie: movie.id)
        destVC.title = movie.title
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
    

}

extension MoviesVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        isSearching = true
        filteredMovies = movies.filter{
            $0.title.lowercased().contains(filter.lowercased())
        }
        
        updateData(on: filteredMovies)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(on: self.movies)
    }
}
