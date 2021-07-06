//
//  MockSimilarMoviesRepository.swift
//  MoviesInformationAppTests
//
//  Created by Akshuma Trivedi on 04/07/21.
//

import Foundation
@testable import MoviesInformationApp

class MockSimilarMoviesRepository: SimilarMoviesRepositoryProtocol {
    static let shared = MockSimilarMoviesRepository()
    private var movieSimilarMoviesResponse: SimilarMoviesResponse?
    private init() {}
    
    func getSimilarMoives(moiveId: String, pageNo: Int, completionHandler: @escaping (Result<SimilarMoviesResponse, TaskError>) -> Void) {
        let filePath = Bundle(for: type(of: self)).path(forResource: "SimilarMoviesResponse", ofType: "json")
        DummyJsonProcess.shared.processDummyJsonResponse(filePath: filePath) {(result: Result<SimilarMoviesResponse, TaskError>) in
            switch result {
            case .success(let response, _):
                self.movieSimilarMoviesResponse = response
            case .failure:
                break
            }
            completionHandler(result)
        }
    }

    func getSimilarMoviesResponse() -> SimilarMoviesResponse? {
        return movieSimilarMoviesResponse
    }
    
    
}
