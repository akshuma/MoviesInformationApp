//
//  RecentSearchDataOperations.swift
//  MoviesInformationApp
//
//  Created by Akshuma Trivedi on 03/08/21.
//

import Foundation
import UIKit
import CoreData

class RecentSearchDataOperations {
    
    static let shared = RecentSearchDataOperations()
    let managedObjectContext = CoreDataStack.shared.managedContext
    
    // Recent Search data insert in to dataBase
    func insertRecentSearches(movie: Movies) {
        guard let movieId = movie.id,
              let movieTitle = movie.title else { return }
        
        let privateMOC = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateMOC.parent = CoreDataStack.shared.managedContext
        managedObjectContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        
        privateMOC.perform {
            guard let enity = NSEntityDescription.entity(forEntityName: MovieRecentSearch.entityName, in: privateMOC) else { return }
            let recentEntity = MovieRecentSearch(entity: enity, insertInto: privateMOC)
            recentEntity.insertRecentSearch(movieId: movieId, movieName: movieTitle)
            
            do {
                try privateMOC.save()
                self.managedObjectContext.performAndWait {
                    do {
                        try self.managedObjectContext.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
}
