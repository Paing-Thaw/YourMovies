//
//  UpcomingTableViewController.swift
//  YourMovies
//
//  Created by June's MacBook on 11/26/20.
//
import Foundation
import UIKit

class UpcomingTableViewController: UITableViewController {
    let upcomingMovies = ["Popular Mowwvies", "Top Rated Movies", "Your Favorite Movies"]
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upcomingMovies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "upcomingCell", for: indexPath)
        cell.textLabel?.text = upcomingMovies[indexPath.row]
        return cell
    }


}
 
