//
//  MockMovieListingRepository.swift
//  MoviesInformationAppTests
//
//  Created by Akshuma Trivedi on 04/07/21.
//

import Foundation
@testable import MoviesInformationApp

class MockMovieListingRepository: MovieListingRepositoryProtocol {
    static let shared = MockMovieListingRepository()
    private var movieListResponse: MovieListResponse?
    private init() {}
    
    func getNowPlayingMovies(pageNo: Int, completionHandler: @escaping (Result<MovieListResponse, TaskError>) -> Void) {
        let filePath = Bundle(for: type(of: self)).path(forResource: "MovieListing", ofType: "json")
        DummyJsonProcess.shared.processDummyJsonResponse(filePath: filePath) {(result: Result<MovieListResponse, TaskError>) in
            switch result {
            case .success(let response, _):
                self.movieListResponse = response
            case .failure:
                break
            }
            completionHandler(result)
        }
        
    }
    
    func getMovieResonse() -> MovieListResponse? {
        return movieListResponse
    }
    
}
