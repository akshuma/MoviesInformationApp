//
//  SynoypsisRepository.swift
//  MoviesInformationApp
//
//  Created by Akshuma Trivedi on 03/07/21.
//

import UIKit

protocol SynoypsisRepositoryProtocol {
    func getSynoypsis(movieId: String, completionHandler: @escaping(Result<SynoypsisResponse, TaskError>) -> Void)
}

class SynoypsisRepository: SynoypsisRepositoryProtocol {
    
    static let shared = SynoypsisRepository()
    private init() { }
    
    func getSynoypsis(movieId: String, completionHandler: @escaping (Result<SynoypsisResponse, TaskError>) -> Void) {
        let task = HTTPTask()
        task.GET(api: MoviesApis.synoypsisData(movieId: movieId)) { (result: Result<SynoypsisResponse, TaskError>) -> Void in
            DispatchQueue.main.async {
                completionHandler(result)
            }
        }
    }
    
    
}
