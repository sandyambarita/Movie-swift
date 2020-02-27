//
//  FavoriteListVC.swift
//  Movie
//
//  Created by sandy ambarita on 27/02/20.
//  Copyright © 2020 Fundtastic. All rights reserved.
//

import Foundation
import UIKit

class FavoriteListVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var favoriteViewModel = FavoriteViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fethingData()
    }
    
    func fethingData() {
        favoriteViewModel.fetchingData(completion: { (_) in
            DispatchQueue.main.async { [weak self] in
                self!.tableView.reloadData()
            }
        })
    }
    private func registerCell() {
        let nibTableViewNavDateValueCell = UINib(nibName: "MovieCell", bundle: nil)
        tableView.register(nibTableViewNavDateValueCell, forCellReuseIdentifier: "MovieCell")
    }
    
    @IBAction func btnBackOnClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goToMovieDetailFavorite") {
            guard let dataSend = sender as? Int else { return }
            if let nextVC = segue.destination as? MovieDetailVC {
                nextVC.movieDetailViewModel.idMovie = dataSend
            }
        }
    }
        
}

extension FavoriteListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        cell.configureCell(data: favoriteViewModel.moviesAtIndex(index: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "goToMovieDetailFavorite", sender: favoriteViewModel.moviesAtIndex(index: indexPath.row).id)
    }
    
}

