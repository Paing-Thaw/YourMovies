//
//  DetailViewController.swift
//  YourMovies
//
//  Created by June's MacBook on 12/2/20.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift

class DetailViewController: UIViewController {
    
    @IBOutlet weak var watchListButton: UIButton!
    @IBOutlet weak var about: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    
    @IBOutlet var genreLabel: [UILabel]!
    
    
    
    var details: [DetailMovie] = []
    let realm = try! Realm()
    let genresArray: [String] = []
    var detailViewMovieID: String = ""
    var watchList = [FavoriteMovie]()
    
    
    var imageURLToSend = ""
    var movieNameToSend = ""
    var voteToSend: Double = 0.0
    var dateToSend = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovies()
    }
    
    @IBAction func addtoWatchListButton(_ sender: UIButton) {
        
        showAlert()
        
        //        watchListButton.isSelected = !watchListButton.isSelected
        //
        //        if (watchListButton.isSelected)
        //        {
        //            watchListButton.image =
        //        }
        //        else
        //        {
        //            watchListButton.Color = UIColor.red
        //        }
        //    }
        let newFavortieMovie = FavoriteMovie()
//        newFavortieMovie.id = detailViewMovieID
        newFavortieMovie.name = movieNameToSend
        newFavortieMovie.URL = imageURLToSend
        newFavortieMovie.rating = voteToSend
        newFavortieMovie.date = dateToSend
        
        self.watchList.append(newFavortieMovie)
        self.save(movie: newFavortieMovie)
    }
    
    func showAlert() {
        let alert = UIAlertController (title: "Added to Watch List" , message: "You can view your watch lists movies on Watch List Screen", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(alert, animated: true)
    }
    
    func save(movie: FavoriteMovie) {
        do {  
            try realm.write {
                realm.add(movie)
            }
        } catch {
            print(error)
        }
    }
    
    
    func fetchMovies() {
        let url = "https://api.themoviedb.org/3/movie/\(detailViewMovieID)?api_key=b6fe07a8389b1a5651b5d7f13fee39fa&language=en-US"
        print(url)
        
        Alamofire.request(url, method: .get).responseJSON { (response) in
            if response.result.isSuccess {
                let movieJSON: JSON = JSON(response.result.value!)
                
                let name = movieJSON["original_title"].stringValue
                let image = movieJSON["poster_path"].stringValue
                let vote = movieJSON["vote_average"].doubleValue
                let date = movieJSON["release_date"].stringValue
                let overview = movieJSON["overview"].stringValue
                let time = movieJSON["runtime"].intValue
                let genresArray = movieJSON["genres"].arrayValue
                
                for i in genresArray {
                    let genres = i["name"]
                    print(genres)
                }
                let imageURL = "https://image.tmdb.org/t/p/w500/\(image)"
                self.movieImage.sd_setImage(with: URL(string: imageURL))
                self.name.text = name
                self.about.text = "Description: \(overview)"
                self.runtimeLabel.text = String("\(time) mins")
                self.ratingLabel.text = String(vote)
                
                // to send watch list view controller
                self.imageURLToSend = imageURL
                self.movieNameToSend = name
                self.voteToSend = vote
                self.dateToSend = date
            }
            
        }
         
    }
    
    
    
    
}
