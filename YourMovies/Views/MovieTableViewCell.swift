//
//  MovieTableViewCell.swift
//  YourMovies
//
//  Created by June's MacBook on 12/1/20.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var movieLabel: UILabel!
    
    @IBOutlet weak var movieImage: UIImageView!
    
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
