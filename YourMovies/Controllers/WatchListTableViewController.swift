//
//  WatchListTableViewController.swift
//  YourMovies
//
//  Created by June's MacBook on 12/3/20.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import RealmSwift

class WatchListTableViewController: UITableViewController {
    let realm = try! Realm()
    var favoriteMovie: Results<FavoriteMovie>!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "reusableCell")
        loadMovies()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return favoriteMovie?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reusableCell", for: indexPath) as! MovieTableViewCell
        cell.movieLabel.text = favoriteMovie[indexPath.row].name
        let imageURL = favoriteMovie[indexPath.row].URL
        cell.movieImage.sd_setImage(with: URL(string: imageURL))
        cell.ratingLabel.text = String(favoriteMovie[indexPath.row].rating)
        cell.dateLabel.text = favoriteMovie[indexPath.row].date
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = favoriteMovie?[indexPath.row] {
            do {
                try realm.write {
                    realm.delete(item)
                }
            } catch {
                print("Error deleting the movie data \(error)")
            }
        }
        tableView.reloadData()
    }
    
    func loadMovies() {
        favoriteMovie = realm.objects(FavoriteMovie.self)
        
        tableView.reloadData()
    }
    
    
    
    
    
    
}
