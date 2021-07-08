//
//  MovieRecentSearch+CoreDataClass.swift
//  MoviesInformationApp
//
//  Created by Akshuma Trivedi on 06/07/21.
//
//

import Foundation
import CoreData

@objc(MovieRecentSearch)
public class MovieRecentSearch: NSManagedObject {
    static let entityName = "MovieRecentSearch"
    
    func insertRecentSearch(movieId: Int64, movieName: String) {
        self.movieName = movieName
        self.movieId = movieId
        self.date = Date()
    }
}
