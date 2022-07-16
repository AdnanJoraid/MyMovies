//
//  Movie.swift
//  MyMovies
//
//  Created by Adnan Joraid on 2022-07-16.
//

import Foundation

struct Movie: Codable {
    let id: String
    let title: String
    let imDbRating: String
    let image: String
}
