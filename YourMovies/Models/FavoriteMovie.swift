//
//  FavoriteMovie.swift
//  YourMovies
//
//  Created by June's MacBook on 12/3/20.
//

import Foundation
import RealmSwift

class FavoriteMovie: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var URL: String = ""
    @objc dynamic var rating: Double = 0.0
    @objc dynamic var date: String = ""
}
