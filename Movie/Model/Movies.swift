//
//  Movies.swift
//  Movie
//
//  Created by sandy ambarita on 25/02/20.
//

import Foundation

struct Movies: Codable {
    let results: [MoviesData]?
}

struct MoviesData: Codable {
    let id: Int?
    let posterPath: String?
    let title: String?
    let releaseDate: String?
    let overview: String?
    
    public enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case title
        case releaseDate = "release_date"
        case overview
    }
}

struct MovieReview: Codable {
    let results: [MovieReviewData]?
}

struct MovieReviewData: Codable {
    let id: String?
    let author: String?
    let content: String?
    let url: String?
}
