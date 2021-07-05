//
//  MovieSearchRepository.swift
//  MoviesInformationApp
//
//  Created by Akshuma Trivedi on 05/07/21.
//

import UIKit

protocol MovieSearchRepositoryProtocol {
    func getSearchMovies(query: String, pageNo: Int, completionHandler: @escaping (Result<MovieListResponse, TaskError>) -> Void)
}

class MovieSearchRepository: MovieSearchRepositoryProtocol {
    static let shared = MovieSearchRepository()
    private init() {}
    
    func getSearchMovies(query: String, pageNo: Int, completionHandler: @escaping (Result<MovieListResponse, TaskError>) -> Void) {
        let task = HTTPTask()
        task.GET(api: MoviesApis.moiveList(pageNo: pageNo)) { (result: Result<MovieListResponse, TaskError>) -> Void in
            DispatchQueue.main.async {
                completionHandler(result)
            }
        }
    }
}

