//
//  RecentSearches.swift
//  MovieApp
//
//  Created by Vishmita Shetty on 25/04/21.
//

//import Foundation
//import CoreData
//
//class RecentSearchDataOperations {
//    static let shared = RecentSearchDataOperations()
//    let managedObjectContext = CoreDataStack.shared.managedContext
//    
//    func insertRecentSearches(movie: Movies) {
//        guard let movieId = movie.id,
//              let movieTitle = movie.title else { return }
//        
//        let privateMOC = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
//        privateMOC.parent = CoreDataStack.shared.managedContext
//        managedObjectContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
//        
//        privateMOC.perform {
//            guard let enity = NSEntityDescription.entity(forEntityName: Search.entityName, in: privateMOC) else { return }
//            let recentEntity = Search(entity: enity, insertInto: privateMOC)
//            recentEntity.insertRecentSearch(movieId: movieId, movieName: movieTitle)
//            
//            do {
//                try privateMOC.save()
//                self.managedObjectContext.performAndWait {
//                    do {
//                        try self.managedObjectContext.save()
//                    } catch {
//                        print(error.localizedDescription)
//                    }
//                }
//            }
//            catch {
//                print(error.localizedDescription)
//            }
//        }
//    }
//}
