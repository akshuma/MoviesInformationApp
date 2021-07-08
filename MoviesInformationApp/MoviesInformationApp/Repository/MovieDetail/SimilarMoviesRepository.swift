//
//  SimilarMoviesRepository.swift
//  MoviesInformationApp
//
//  Created by Akshuma Trivedi on 03/07/21.
//

import UIKit

protocol SimilarMoviesRepositoryProtocol {
    func getSimilarMoives(moiveId: String, pageNo: Int, completionHandler: @escaping(Result<SimilarMoviesResponse, TaskError>) -> Void)
}

class SimilarMoviesRepository: SimilarMoviesRepositoryProtocol {
    static let shared = SimilarMoviesRepository()
    private init() { }
    
    //Similar moive data 
    func getSimilarMoives(moiveId: String, pageNo: Int, completionHandler: @escaping (Result<SimilarMoviesResponse, TaskError>) -> Void) {
        let task = HTTPTask()
        task.GET(api: MoviesApis.similarMovies(movieId: moiveId, pageNo: pageNo)) { (result: Result<SimilarMoviesResponse, TaskError>) in
            DispatchQueue.main.async {
                completionHandler(result)
            }
        }
        
    }
    

}
