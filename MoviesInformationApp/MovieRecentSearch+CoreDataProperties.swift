//
//  MovieRecentSearch+CoreDataProperties.swift
//  MoviesInformationApp
//
//  Created by Akshuma Trivedi on 06/07/21.
//
//

import Foundation
import CoreData


extension MovieRecentSearch {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieRecentSearch> {
        return NSFetchRequest<MovieRecentSearch>(entityName: "MovieRecentSearch")
    }
    
    @NSManaged public var movieId: Int64
    @NSManaged public var movieName: String?
    @NSManaged public var date: Date?
    
}

extension MovieRecentSearch : Identifiable {
    
}

