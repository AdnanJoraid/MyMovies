//
//  MovieDetailsVC.swift
//  MyMovies
//
//  Created by Adnan Joraid on 2022-07-17.
//

import UIKit

class MovieDetailsVC: UIViewController {
    let movie: String
    var movieDetial: MovieDetails?
    let moviePoster: MoviePosterImageView = MoviePosterImageView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        getMovieDetailsById(for: movie)
        configureViewController()
        styleViews()
    }
    
    init(movie: String) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    private func getMovieDetailsById(for movieId: String){
        showLoadingView()
        NetworkManager.shared.getMovieDetails(for: movieId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movie):
                self.movieDetial = movie
                guard let mo = self.movieDetial else { return }
                DispatchQueue.main.async {
                    self.moviePoster.downloadImage(from: mo.image)
                }
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "Ok")
            }
            
        }
        dismissLoadingView()

    }
    
    private func configureViewController() {
        view.backgroundColor = .black
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        doneButton.tintColor = .red
        addButton.tintColor = .red
        navigationItem.leftBarButtonItem = doneButton
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func dismissVC() {
        dismiss(animated: true )
    }
    
    @objc func addButtonTapped() {
        guard let movieDetial = movieDetial else {
            return
        }

        PersistenceManager.updateWith(movie: movieDetial, actionType: .add) { [weak self] error in
            guard let self = self else {return}
            guard let error = error else { return }
            self.presentAlertOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "Ok")
        }

        self.presentAlertOnMainThread(title: "Success!", message: "This movie has been added to your list", buttonTitle: "Ok")
    }
    
    func styleViews() {
        
        view.addSubview(moviePoster)
        
        
        NSLayoutConstraint.activate([
            moviePoster.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            moviePoster.widthAnchor.constraint(equalToConstant: 160),
            moviePoster.heightAnchor.constraint(equalToConstant: 240),
            moviePoster.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

