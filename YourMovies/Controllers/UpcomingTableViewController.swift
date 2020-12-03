//
//  UpcomingTableViewController.swift
//  YourMovies
//
//  Created by June's MacBook on 11/26/20.
//
import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class UpcomingTableViewController: UITableViewController {
    var upcoming: [Movies] = []
    private var upcomingMovieNames = [String]()
    
    private let upcomingMoviesURL = "https://api.themoviedb.org/3/movie/upcoming?api_key=b6fe07a8389b1a5651b5d7f13fee39fa&language=en-US"
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestUpcomingMovies()
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "reusableCell") 
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upcoming.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reusableCell", for: indexPath) as! MovieTableViewCell
        let url = "https://image.tmdb.org/t/p/w500/\(upcoming[indexPath.row].imageURL)"
        cell.movieLabel.text = upcoming[indexPath.row].movieName
        cell.movieImage.sd_setImage(with: URL(string: url))
        cell.ratingLabel.text = String(upcoming[indexPath.row].rating)
        cell.dateLabel.text = upcoming[indexPath.row].date
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            let id = self.upcoming[indexPath.row].movieID
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
            vc?.detailViewMovieID = id
            self.navigationController?.pushViewController(vc!, animated: true)
            
        }
        
        
    }
    
    func requestUpcomingMovies() {
        Alamofire.request(upcomingMoviesURL, method: .get).responseJSON { (response) in
            if response.result.isSuccess {
                
                
                //                print(response)
                let myResult = try? JSON(data: response.data!)
                
                let resultArray = myResult!["results"]
                for i in resultArray.arrayValue {
                    let id = i["id"].stringValue
                    let name = i["original_title"].stringValue
                    let image = i["poster_path"].stringValue
                    let vote = i["vote_average"].doubleValue
                    let date = i["release_date"].stringValue
                    self.upcoming.append(Movies(movieID: id, movieName: name, imageURL: image, rating: vote, date: date))
                    
                }
                self.tableView.reloadData()
                
                
                
            }
        }
    }
    
    
}

