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
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Movie>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMovies()
        configureCollectionView()
        configureDataSource()
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout())
        view.addSubview(collectionView)
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseID)
    }
    
    
    func getMovies() {
        NetworkManager.shared.getTopMovies { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movies):
                self.movies = movies.items
                self.updateData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout {
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
    
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
        snapshot.appendSections([.main])
        snapshot.appendItems(movies)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }

}

