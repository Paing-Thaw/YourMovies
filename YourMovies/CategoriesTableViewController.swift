//
//  CategoriesTableViewController.swift
//  YourMovies
//
//  Created by June's MacBook on 11/23/20.
//
import Foundation
import UIKit

class CategoriesTableViewController: UITableViewController {
    
    let moviesCategories = ["Popular Movies", "Top Rated Movies", "Your Favorite Movies"]
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesCategories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        cell.textLabel?.text = moviesCategories[indexPath.row]
        return cell
    }
    

}
