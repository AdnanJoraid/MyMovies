//
//  PersistenceManager.swift
//  MyMovies
//
//  Created by Adnan Joraid on 2022-07-18.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let list = "list"
    }
    
    static func updateWith(movie: MovieDetails, actionType: PersistenceActionType, completion: @escaping (MyMoviesErrorMessage?) -> Void) {
        retrieveMovies { result in
            switch result {
                
            case .success(let movies):
                var retrievedMovies = movies
                
                switch actionType {
                case .add:
                    guard !retrievedMovies.contains(where: {$0.title == movie.title}) else {
                        completion(.aleadyInList)
                        return
                    }
                    retrievedMovies.append(movie)
                    
                case .remove:
                    retrievedMovies.removeAll {$0.title == movie.title}
                }
                
                completion(saveFavorites(movies: retrievedMovies))
            case .failure(let error):
                completion(error)

            }
        }
    }
    
    static func retrieveMovies(completed: @escaping (Result<[MovieDetails], MyMoviesErrorMessage>) -> Void) {

        
        guard let movieData = defaults.object(forKey: Keys.list) as? Data else {
                completed(.success([]))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let mov = try decoder.decode([MovieDetails].self, from: movieData)
                completed(.success(mov))
            } catch {
                completed(.failure(.unableToComplete))
            }
        }
        
        static func saveFavorites(movies: [MovieDetails]) -> MyMoviesErrorMessage? {
         
            do {
                let encoder = JSONEncoder()
                let encodedMovie = try encoder.encode(movies)
                defaults.set(encodedMovie, forKey: Keys.list)
                return nil
            } catch {
                return .unableToComplete
            }
        }
}
