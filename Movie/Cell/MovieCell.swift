//
//  MovieCell.swift
//  Movie
//
//  Created by sandy ambarita on 25/02/20.
//

import UIKit

class MovieCell: UITableViewCell {
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var lblMovieReleaseDate: UILabel!
    @IBOutlet weak var lblMovieDesc: UILabel!
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var viewMovie: UIView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        viewMovie.layoutIfNeeded()
        viewMovie.layer.masksToBounds = false
        viewMovie.layer.borderWidth = 1.0
        viewMovie.layer.borderColor = UIColor.white.cgColor
        viewMovie.layer.shadowColor = UIColor.lightGray.cgColor
        viewMovie.layer.shadowRadius = 5
        viewMovie.layer.shadowOpacity = 1
        viewMovie.layer.shadowOffset = CGSize(width:2, height: 0)
    }

    func configureCell(data: MoviesData) {
        lblMovieTitle.text = data.title
        lblMovieReleaseDate.text = data.releaseDate?.formatDate()
        lblMovieDesc.text = data.overview
        imgMovie.loadFromUrl(url: URL(string: "\(Endpoint.BaseImage)\(data.posterPath!)")!)
    }
    
}
