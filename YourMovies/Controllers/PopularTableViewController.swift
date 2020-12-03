//
//  CategoriesTableViewController.swift
//  YourMovies
//
//  Created by June's MacBook on 11/23/20.
//
import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class PopularTableViewController: UITableViewController {
    var popular: [Movies] = []
    //    private var upcomingMovieNames = [String]()
    
    private let popularMoviesURL = "https://api.themoviedb.org/3/movie/popular?api_key=b6fe07a8389b1a5651b5d7f13fee39fa&language=en-US&page=1"
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestUpcomingMovies()
        print(popularMoviesURL)
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "reusableCell")
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return popular.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reusableCell", for: indexPath) as! MovieTableViewCell
        let url = "https://image.tmdb.org/t/p/w500/\(popular[indexPath.row].imageURL)"
        cell.movieLabel.text = popular[indexPath.row].movieName
        cell.movieImage.sd_setImage(with: URL(string: url))
        cell.ratingLabel.text = String(popular[indexPath.row].rating)
        cell.dateLabel.text = popular[indexPath.row].date
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            let id = self.popular[indexPath.row].movieID
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
            vc?.detailViewMovieID = id
            self.navigationController?.pushViewController(vc!, animated: true)
            
        }
        
        
    }
    
    func requestUpcomingMovies() {
        Alamofire.request(popularMoviesURL, method: .get).responseJSON { (response) in
            if response.result.isSuccess {
                print("Got Upcoming Movies Info")
                
                //                print(response)
                let myResult = try? JSON(data: response.data!)
                
                let resultArray = myResult!["results"]
                for i in resultArray.arrayValue {
                    let id = i["id"].stringValue
                    let name = i["original_title"].stringValue
                    let image = i["poster_path"].stringValue
                    let vote = i["vote_average"].doubleValue
                    let date = i["release_date"].stringValue
                    self.popular.append(Movies(movieID: id, movieName: name, imageURL: image, rating: vote, date: date))
                    
                }
                self.tableView.reloadData()
                
                
            }
        }
    }
    
    
}

