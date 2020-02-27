//
//  MovieViewModel.swift
//  Movie
//
//  Created by sandy ambarita on 26/02/20.
//  Copyright © 2020 Fundtastic. All rights reserved.
//

enum categories {
    case popular
    case topRated
    case nowPlaying
}

import Foundation

class MoviesViewModel {
    var movies: [MoviesData] = []
    var apimanager = APIManager()
    
    var isOpen: Bool = false
    var isAccessApiMovies = false
    
    func fetchMovies(category: categories, completion: @escaping([MoviesData]?) -> ()) {
        apimanager.getMovies(category: category) { (data) in
            if data != nil {
                do {
                    let decoder = JSONDecoder()
                    let movies = try decoder.decode(Movies.self, from: data!)
                    self.movies = movies.results!
                    self.isAccessApiMovies = true
                    completion(movies.results)
                } catch {
                    print("error trying to convert data to JSON: \(error)")
                }
            } else {
                print("nil")
            }
        }
    }
    
    func numberOfRowsInSection() -> Int {
        return self.movies.count
    }
    
    func moviesAtIndex(index: Int) -> MoviesData {
        let movie = self.movies[index]
        return movie
    }
    
    func buttonCategoryAction(completion: (Bool) -> ()) {
        if isOpen {
            isOpen = false
            completion(isOpen)
        } else {
            isOpen = true
            completion(isOpen)
        }
    }
}
