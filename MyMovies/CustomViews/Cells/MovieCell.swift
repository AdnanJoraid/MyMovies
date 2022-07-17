//
//  MovieCell.swift
//  MyMovies
//
//  Created by Adnan Joraid on 2022-07-16.
//

import UIKit

class MovieCell: UICollectionViewCell {
    let moviePosterView = MoviePosterImageView(frame: .zero)
    let movieNameLabel = MovieTitleLabel(textAlignment: .center, fontSize: 16)
    static let reuseID = "MovieCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(movie: Movie) {
        movieNameLabel.text = movie.title
        moviePosterView.downloadImage(from: movie.image)
        
    }
    
    private func configure() {
        addSubview(moviePosterView)
        addSubview(movieNameLabel)
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            moviePosterView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            moviePosterView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            moviePosterView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            moviePosterView.heightAnchor.constraint(equalToConstant: 200),
            moviePosterView.widthAnchor.constraint(equalToConstant: 150),
            
            movieNameLabel.topAnchor.constraint(equalTo: moviePosterView.bottomAnchor, constant: padding),
            movieNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            movieNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            movieNameLabel.heightAnchor.constraint(equalToConstant: 12)
        ])
    }
}
