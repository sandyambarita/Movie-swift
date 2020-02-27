//
//  MovieDetailVC.swift
//  Movie
//
//  Created by sandy ambarita on 26/02/20.
//  Copyright © 2020 Fundtastic. All rights reserved.
//

import Foundation
import UIKit

class MovieDetailVC: UIViewController {
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var lblMovieDetailTitle: UILabel!
    @IBOutlet weak var lblMovieReleaseDate: UILabel!
    @IBOutlet weak var lblMovieDesc: UILabel!
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var viewMovie: UIView!
    @IBOutlet weak var btnFavorite: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var apimanager = APIManager()
    var movieDetailViewModel = MovieDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewMovie.showAnimatedGradientSkeleton()
        fetchData()
        setupShadow()
        registerCell()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func fetchData() {
        movieDetailViewModel.fetchMovieDetail(completion: {_ in 
            self.viewMovie.hideSkeleton()
            self.setupLayout()
        })
        movieDetailViewModel.fetchMovieDetailReview(completion: {_ in
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        })
    }
    
    private func registerCell() {
        let nibTableViewNavDateValueCell = UINib(nibName: "ReviewCell", bundle: nil)
        tableView.register(nibTableViewNavDateValueCell, forCellReuseIdentifier: "ReviewCell")
    }
    
    private func setupLayout() {
        lblMovieTitle.text = movieDetailViewModel.title
        lblMovieDetailTitle.text = movieDetailViewModel.title
        lblMovieReleaseDate.text = movieDetailViewModel.releaseDate
        lblMovieDesc.text = movieDetailViewModel.overviewDesc
        imgMovie.loadFromUrl(url: URL(string: "\(Endpoint.BaseImage)\(movieDetailViewModel.image)")!)
        if movieDetailViewModel.isFavorite! {
            btnFavorite.setImage(UIImage(named: "ic_favorite"), for: .normal)
        } else {
            btnFavorite.setImage(UIImage(named: "ic_unfavorite"), for: .normal)
        }
    }
    
    private func setupShadow() {
        viewMovie.layoutIfNeeded()
        viewMovie.layer.masksToBounds = false
        viewMovie.layer.borderWidth = 1.0
        viewMovie.layer.borderColor = UIColor.white.cgColor
        viewMovie.layer.shadowColor = UIColor.lightGray.cgColor
        viewMovie.layer.shadowRadius = 5
        viewMovie.layer.shadowOpacity = 1
        viewMovie.layer.shadowOffset = CGSize(width:2, height: 0)
    }
    
    @IBAction func btnBackOnClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnFavoriteOnClicked(_ sender: Any) {
        movieDetailViewModel.favoriteAction { (isFavorite) in
            if isFavorite {
                btnFavorite.setImage(UIImage(named: "ic_favorite"), for: .normal)
            } else {
                btnFavorite.setImage(UIImage(named: "ic_unfavorite"), for: .normal)
            }
        }
    }
}

extension MovieDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if movieDetailViewModel.isAccessApiMovieDetail {
            if movieDetailViewModel.numberOfRowsInSection() > 0 {
                return movieDetailViewModel.numberOfRowsInSection()
            } else {
                let emptyLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.size.width, height: self.tableView.bounds.size.height))
                emptyLabel.text = "Empty Data"
                emptyLabel.textColor = UIColor.black
                emptyLabel.textAlignment = NSTextAlignment.center
                self.tableView.backgroundView = emptyLabel
            }
            return movieDetailViewModel.numberOfRowsInSection()
        } else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell") as? ReviewCell
        if movieDetailViewModel.isAccessApiMovieDetail {
            cell?.hideSkeleton()
            cell?.configureCell(data: movieDetailViewModel.moviesAtIndex(index: indexPath.row))
            return cell!
        } else {
            cell?.showAnimatedGradientSkeleton()
        }
        return UITableViewCell()
        
    }
    
    
}

