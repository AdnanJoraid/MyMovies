//
//  ErrorMessage.swift
//  MyMovies
//
//  Created by Adnan Joraid on 2022-07-16.
//

import Foundation

enum MyMoviesErrorMessage: String, Error {
    case invalidApiUrl = "Error. This problem from the server side. Please try again"
    case invalidResponse = "Invalid response from the server. Please try again"
    case invalidData = "The data received from the server was invalid. Please try again"
    case unableToComplete = "Unable to complete your request. Please try again"
    case decodingError = "The data is not being processed. Please try again"
}
