//
//  MovieVC.swift
//  Movie
//
//  Created by sandy ambarita on 25/02/20.
//

import UIKit
import SkeletonView

class MovieVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnPopular: UIButton!
    @IBOutlet weak var btnTopRated: UIButton!
    @IBOutlet weak var btnNowPlaying: UIButton!
    
    var moviesViewModel = MoviesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if moviesViewModel.isOpen {
            showCategory()
        } else {
            hideCategory()
        }
        btnPopular.setTitleColor(UIColor.gray, for: .normal)
        registerCell()
        fetchData(category: categories.popular)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func registerCell() {
        let nibTableViewNavDateValueCell = UINib(nibName: "MovieCell", bundle: nil)
        tableView.register(nibTableViewNavDateValueCell, forCellReuseIdentifier: "MovieCell")
    }
    
    private func hideCategory() {
        btnPopular.isHidden = true
        btnTopRated.isHidden = true
        btnNowPlaying.isHidden = true
    }
    
    private func showCategory() {
        btnPopular.isHidden = false
        btnTopRated.isHidden = false
        btnNowPlaying.isHidden = false
    }
    
    func fetchData(category: categories) {
        moviesViewModel.fetchMovies(category: category, completion: { (_) in
            DispatchQueue.main.async { [weak self] in
                self!.tableView.reloadData()
            }
        })
    }
    
    @IBAction func btnPopularOnClicked(_ sender: Any) {
        tableView.showAnimatedGradientSkeleton()
        fetchData(category: categories.popular)
        btnPopular.setTitleColor(UIColor.gray, for: .normal)
        btnTopRated.setTitleColor(UIColor.black, for: .normal)
        btnNowPlaying.setTitleColor(UIColor.black, for: .normal)
    }
    
    @IBAction func btnTopRatedOnClicked(_ sender: Any) {
        tableView.showAnimatedGradientSkeleton()
        fetchData(category: categories.topRated)
        btnPopular.setTitleColor(UIColor.black, for: .normal)
        btnTopRated.setTitleColor(UIColor.gray, for: .normal)
        btnNowPlaying.setTitleColor(UIColor.black, for: .normal)
    }
    
    @IBAction func btnNowPlayingOnClicked(_ sender: Any) {
        tableView.showAnimatedGradientSkeleton()
        fetchData(category: categories.nowPlaying)
        btnPopular.setTitleColor(UIColor.black, for: .normal)
        btnTopRated.setTitleColor(UIColor.black, for: .normal)
        btnNowPlaying.setTitleColor(UIColor.gray, for: .normal)
    }
    
    @IBAction func btnCategoryOnClicked(_ sender: Any) {
        moviesViewModel.buttonCategoryAction { (isOpen) in
            if isOpen {
                showCategory()
            } else {
                hideCategory()
            }
        }
    }
    
    @IBAction func btnFavoriteOnClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "goToFavoriteListVC", sender: moviesViewModel.movies)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goToMovieDetail") {
            guard let dataSend = sender as? Int else { return }
            if let nextVC = segue.destination as? MovieDetailVC {
                nextVC.movieDetailViewModel.idMovie = dataSend
            }
        } else if (segue.identifier == "goToFavoriteListVC") {
            guard let dataSend = sender as? [MoviesData] else {return}
            if let nextVC = segue.destination as? FavoriteListVC {
                nextVC.favoriteViewModel.allMovies = dataSend
            }
        }
    }
    
}

extension MovieVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if moviesViewModel.isAccessApiMovies {
            return (moviesViewModel.numberOfRowsInSection())
        } else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        if moviesViewModel.isAccessApiMovies {
            tableView.hideSkeleton()
            cell.hideSkeleton()
            cell.configureCell(data: moviesViewModel.moviesAtIndex(index: indexPath.row))
        } else {
            cell.showAnimatedGradientSkeleton()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "goToMovieDetail", sender: moviesViewModel.moviesAtIndex(index: indexPath.row).id)
    }
    
}

