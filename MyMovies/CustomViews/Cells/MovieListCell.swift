//
//  MovieListCell.swift
//  MyMovies
//
//  Created by Adnan Joraid on 2022-07-18.
//

import Foundation
import UIKit

class MovieListCell: UITableViewCell {
    static let reuseId = "MovieListCell"
    let moviePosterView = MoviePosterImageView(frame: .zero)
    let movieNameLabel = MovieTitleLabel(textAlignment: .left, fontSize: 26)
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    func set(movie: MovieDetails){
        self.moviePosterView.downloadImage(from: movie.image)
        self.movieNameLabel.text = movie.title
    }
    
    
    private func configure() {
        addSubview(moviePosterView)
        addSubview(movieNameLabel)
        
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            moviePosterView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            moviePosterView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            moviePosterView.heightAnchor.constraint(equalToConstant: 95),
            moviePosterView.widthAnchor.constraint(equalToConstant: 65),
            
            movieNameLabel.leadingAnchor.constraint(equalTo: moviePosterView.leadingAnchor, constant: 80),
            movieNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            movieNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            movieNameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
