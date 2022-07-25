//
//  FavoriteMoviesVC.swift
//  MyMovies
//
//  Created by Adnan Joraid on 2022-07-16.
//

import UIKit

class MoviesListVC: UIViewController {
    
    let tableView = UITableView()
    var movieList = [MovieDetails]()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getMovieList()
    }
    
    private func configureViewController() {
        view.backgroundColor = .black
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 120
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MovieListCell.self, forCellReuseIdentifier: MovieListCell.reuseId)
    }
    
    private func getMovieList() {
        PersistenceManager.retrieveMovies { result in
            switch result {
                
            case .success(let movies):
                if movies.isEmpty {
                    print("Empty")
                } else {
                    self.movieList = movies
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                    
                }
                
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }


}

//MARK: - EXTENSIONS

extension MoviesListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieListCell.reuseId) as! MovieListCell
        let movie = movieList[indexPath.row]
        cell.set(movie: movie)
        return cell
    }

        
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let movie = movieList[indexPath.row]
        movieList.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        
        PersistenceManager.updateWith(movie: movie, actionType: .remove, completion: { [weak self] error in
            guard let self = self else { return }
            guard let error = error else { return }

            self.presentAlertOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "Ok")
        })
    }
}
