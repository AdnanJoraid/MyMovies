//
//  MovieDetailsVC.swift
//  MyMovies
//
//  Created by Adnan Joraid on 2022-07-17.
//

import UIKit

class MovieDetailsVC: UIViewController {
    let movie: MovieDetails!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configureViewController()
    }
    
    init(movie: MovieDetails) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
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
        PersistenceManager.updateWith(movie: movie, actionType: .add) { [weak self] error in
            guard let self = self else {return}
            guard let error = error else { return }
            self.presentAlertOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "Ok")
                
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


}
