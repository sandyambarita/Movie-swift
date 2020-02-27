//
//  Extension.swift
//  Movie
//
//  Created by sandy ambarita on 25/02/20.
//

import Foundation
import UIKit
import Kingfisher

extension String {
    func formatDate() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "id_ID")
        formatter.dateFormat = "yyyy-MM-dd"
        let dates = formatter.date(from: self)
        formatter.dateFormat = "dd MMMM yyyy"
        let datesFormat = formatter.string(from: dates!)
        return datesFormat
    }

}

extension UIImageView {
    func loadFromUrl(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        self.kf.setImage(with: url)
        self.contentMode = mode
    }
}

enum UserDefaultsKeys : String {
    case favoriteID
}
extension UserDefaults{
    func setFavoriteID(value: Int){
        var dataFavorites = self.getFavoriteID()
        dataFavorites.append(value)
        set(dataFavorites, forKey: UserDefaultsKeys.favoriteID.rawValue)
    }
    
    func getFavoriteID() -> [Int]{
        return array(forKey: UserDefaultsKeys.favoriteID.rawValue) as? [Int] ?? []
    }
    
    func setRemoveFav(value: [Int]) {
        set(value, forKey: UserDefaultsKeys.favoriteID.rawValue)
    }
    
    func removeFavoriteID(value: Int) {
        var dataFavorites = self.getFavoriteID()
        dataFavorites.remove(at: dataFavorites.firstIndex(of: value)!)
        setRemoveFav(value: dataFavorites)
    }
}
