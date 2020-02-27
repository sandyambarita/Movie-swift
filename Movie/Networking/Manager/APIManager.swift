//
//  APIManager.swift
//  Movie
//
//  Created by sandy ambarita on 25/02/20.
//

import Foundation
import UIKit

class APIManager {
    func getMovies(category: categories, completionHandler: @escaping (Data?) -> ()){
        var endpointCategory = ""
        if category == categories.popular {
            endpointCategory = Endpoint.POPULAR
        } else if category == categories.topRated {
            endpointCategory = Endpoint.TOP_RATED
        } else if category == categories.nowPlaying {
            endpointCategory = Endpoint.NOW_PLAYING
        }
        Connection.request(.get, url: "\(Endpoint.BaseEndpoint)\(endpointCategory)\(Endpoint.ApiKey)") { (data, statusCode, error) in
            if error == nil {
                if statusCode == 200 {
                    completionHandler(data)
                } else {
                    completionHandler(nil)
                }
            }
        }
    }
    func getMovieDetail(id: Int, completionHandler: @escaping (Data?) -> ()){
        Connection.request(.get, url: "\(Endpoint.BaseEndpoint)\(Endpoint.MOVIE_DETAIL)\(id)\(Endpoint.ApiKey)") { (data, statusCode, error) in
            if error == nil {
                if statusCode == 200 {
                    completionHandler(data)
                } else {
                    completionHandler(nil)
                }
            }
        }
    }
    func getMovieDetailReview(id: Int, completionHandler: @escaping (Data?) -> ()){
        Connection.request(.get, url: "\(Endpoint.BaseEndpoint)\(Endpoint.MOVIE_DETAIL)\(id)\(Endpoint.MOVIE_REVIEW)\(Endpoint.ApiKey)") { (data, statusCode, error) in
            if error == nil {
                if statusCode == 200 {
                    completionHandler(data)
                } else {
                    completionHandler(nil)
                }
            }
        }
    }
}
