//
//  FavoriteViewModel.swift
//  Movie
//
//  Created by sandy ambarita on 27/02/20.
//  Copyright © 2020 Fundtastic. All rights reserved.
//

import Foundation

class FavoriteViewModel {
    var favoriteMovies: [MoviesData] = []
    var allMovies: [MoviesData] = []
    var defaults = UserDefaults.standard
    
    func fetchingData(completion: @escaping([MoviesData]?) -> ()) {
        let data = allMovies.filter{defaults.getFavoriteID().contains($0.id!)}
        self.favoriteMovies = data
        completion(data)
    }
    
    func numberOfRowsInSection() -> Int {
        return self.favoriteMovies.count
    }
        
    func moviesAtIndex(index: Int) -> MoviesData {
        let movie = self.favoriteMovies[index]
        return movie
    }
}
