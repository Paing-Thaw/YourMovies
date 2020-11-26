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

class UpcomingTableViewController: UITableViewController {
    private var upcomingMovieNames = [String]()
   
    private let upcomingMoviesURL = "https://api.themoviedb.org/3/movie/upcoming?api_key=b6fe07a8389b1a5651b5d7f13fee39fa&language=en-US&page=1"
    override func viewDidLoad() {
        super.viewDidLoad()
        requestUpcomingMovies()
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upcomingMovieNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "upcomingCell", for: indexPath)
        cell.textLabel?.text = upcomingMovieNames[indexPath.row]
        return cell
    }
    
    func requestUpcomingMovies() {
        Alamofire.request(upcomingMoviesURL, method: .get).responseJSON { (response) in
            if response.result.isSuccess {
                print("Got Upcoming Movies Info")

//                print(response)
                let myResult = try? JSON(data: response.data!)
               
                let resultArray = myResult!["results"]
                for i in resultArray.arrayValue {
                    let movieName = i["original_title"].stringValue
                    self.upcomingMovieNames.append(movieName)
                }
                self.tableView.reloadData()
                
                
                
                //                    let upcomingMoviesJSON: JSON = JSON(response.result.value!)
                //                    let movieName = upcomingMoviesJSON["results"][0]["original_title"].stringValue
                //                    print("Movie name: \(movieName)")
                
                
                
                //                for i in 1...9 {
                //                    if let imageURL = json["data"][i]["images"]["standard_resolution"]["url"].string {
                //                        self.imgURLArray.append(imageURL)
                //                    } else {
                //                        print("no way")
                //                    }
                
            }
        }
    }
    
    
}

