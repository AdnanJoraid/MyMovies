//
//  MovieDetails.swift
//  MyMovies
//
//  Created by Adnan Joraid on 2022-07-16.
//

import Foundation

struct MovieDetails: Codable {
    let id: String
    let title: String
    let year: String
    let image: String
    let releaseDate: String
    let runtimeStr: String
    let plot: String
    let actorList: [Actor]
    let similars: [Movie]
}
