//
//  Favorite.swift
//  Movie
//
//  Created by sandy ambarita on 27/02/20.
//  Copyright © 2020 Fundtastic. All rights reserved.
//

import Foundation

var favorite = Favorite()

struct Favorite: Decodable {
    var data: [FavoriteData]?
}
struct FavoriteData: Decodable {
    var favoriteId: Int?
}
