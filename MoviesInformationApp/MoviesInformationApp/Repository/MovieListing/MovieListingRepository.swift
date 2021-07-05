//
//  MovieListingRepository.swift
//  MoviesInformationApp
//
//  Created by Akshuma Trivedi on 03/07/21.
//

import Foundation

protocol MovieListingRepositoryProtocol {
    func getNowPlayingMovies(pageNo: Int, completionHandler: @escaping(Result<MovieListResponse,TaskError>) -> Void)
}

class MovieListingRepository: MovieListingRepositoryProtocol {
    static let shared = MovieListingRepository()
    private init() {}
    
    func getNowPlayingMovies(pageNo: Int, completionHandler: @escaping (Result<MovieListResponse, TaskError>) -> Void) {
        let task = HTTPTask()
        task.GET(api: MoviesApis.moiveList(pageNo: pageNo)) { (result: Result<MovieListResponse, TaskError>) -> Void in
            DispatchQueue.main.async {
                completionHandler(result)
            }
        }
        
        
    }
    
    
}
