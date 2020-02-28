//
//  MovieDetailViewModel.swift
//  Movie
//
//  Created by sandy ambarita on 26/02/20.
//  Copyright © 2020 Fundtastic. All rights reserved.
//

import Foundation

class MovieDetailViewModel {
    var movieDetail: MoviesData?
    var movieReview: [MovieReviewData] = []
    var apimanager = APIManager()
    var idMovie: Int?
    var isFavorite: Bool? = false
    var defaults = UserDefaults.standard
    var isAccessApiMovieDetail = false
    
    var title: String {
        return (movieDetail?.title)!
    }
    
    var releaseDate: String {
        return (movieDetail?.releaseDate!.formatDate())!
    }
    
    var image: String {
        return (movieDetail?.posterPath)!
    }
    
    var overviewDesc: String {
        return (movieDetail?.overview)!
    }
    
    func fetchMovieDetail(completion: @escaping(MoviesData?) -> ()) {
        apimanager.getMovieDetail(id: idMovie!) { (data) in
            if data != nil {
                do {
                    let decoder = JSONDecoder()
                    let movies = try decoder.decode(MoviesData.self, from: data!)
                    self.movieDetail = movies
                    self.getFavorite()
                    completion(movies)
                } catch {
                    print("error trying to convert data to JSON: \(error)")
                }
            } else {
                print("nil")
            }
        }
    }
    
    func fetchMovieDetailReview(completion: @escaping([MovieReviewData]?) -> ()) {
        apimanager.getMovieDetailReview(id: idMovie!) { (data) in
            if data != nil {
                do {
                    let decoder = JSONDecoder()
                    let movieReviewData = try decoder.decode(MovieReview.self, from: data!)
                    self.movieReview = movieReviewData.results!
                    self.isAccessApiMovieDetail = true
                    completion(movieReviewData.results)
                } catch {
                    print("error trying to convert data to JSON: \(error)")
                }
            } else {
                print("nil")
            }
        }
    }
    
    func getFavorite() {
        for favoriteId in defaults.getFavoriteID() {
            if idMovie == favoriteId{
                isFavorite = true
                break
            }
        }
    }
    
    func favoriteAction(completion: (Bool) -> ()) {
        if self.isFavorite! {
            defaults.removeFavoriteID(value: idMovie!)
            isFavorite = false
            completion(isFavorite!)
            
        } else {
            defaults.setFavoriteID(value: idMovie!)
            isFavorite = true
            completion(isFavorite!)
        }
    }
    
    func numberOfRowsInSection() -> Int {
        return self.movieReview.count
    }
        
    func moviesAtIndex(index: Int) -> MovieReviewData {
        let movieReview = self.movieReview[index]
        return movieReview
    }
}
