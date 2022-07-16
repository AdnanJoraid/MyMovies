//
//  NetworkManager.swift
//  MyMovies
//
//  Created by Adnan Joraid on 2022-07-16.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    private let topMoviesUrl = "https://imdb-api.com/en/API/Top250Movies/"
    private let movieDetailsUrl = "https://imdb-api.com/en/API/Title/"
    let cache = NSCache<NSString, UIImage>()
    
    private init(){}
    
    func getTopMovies(completion: @escaping (Result<Items, MyMoviesErrorMessage>) -> Void) {
        let endpoint = topMoviesUrl + CONSTANT.apikey
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidApiUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, respone, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let respone = respone as? HTTPURLResponse, respone.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let items = try decoder.decode(Items.self, from: data)
                completion(.success(items))
            } catch {
                completion(.failure(.invalidData))
            }

        }
        
        task.resume()
    }
    
    func getMovieDetails(for id: String, completion: @escaping (Result<MovieDetails, MyMoviesErrorMessage>) -> Void) {
        let endpoint = movieDetailsUrl + "\(CONSTANT.apikey)/\(id)/Wikipedia"
        print(endpoint)
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidApiUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, respone, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let respone = respone as? HTTPURLResponse, respone.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
                        
            do {
                let decoder = JSONDecoder()
                let movieDetails = try decoder.decode(MovieDetails.self, from: data)
                completion(.success(movieDetails))
            } catch {
                completion(.failure(.decodingError))
                print(error)
                return
            }
        }
        
        task.resume()
    }
}



