//
//  CreditsRepository.swift
//  MoviesInformationApp
//
//  Created by Akshuma Trivedi on 03/07/21.
//

import UIKit

protocol CreditsRepositoryProtocol {
    func getCredits(movieId: String, completionHandler: @escaping(Result<CreditsResponse,TaskError>) -> Void)
    
}

class CreditsRepository: CreditsRepositoryProtocol {
    static let shared = CreditsRepository()
    private init() { }
    
    // Cast and Crew data API
    func getCredits(movieId: String, completionHandler: @escaping (Result<CreditsResponse, TaskError>) -> Void) {
        let task = HTTPTask()
        task.GET(api: MoviesApis.credits(movieId: movieId)) { (result: Result<CreditsResponse, TaskError>) in
            DispatchQueue.main.async {
                completionHandler(result)
            }
        }
        
    }
    

}
