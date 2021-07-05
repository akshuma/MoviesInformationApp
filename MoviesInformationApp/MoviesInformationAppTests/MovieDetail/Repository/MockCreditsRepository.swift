//
//  MockCreditsRepository.swift
//  MoviesInformationAppTests
//
//  Created by Akshuma Trivedi on 04/07/21.
//

import Foundation
@testable import MoviesInformationApp

class MockCreditsRepository: CreditsRepositoryProtocol {
    static let shared = MockCreditsRepository()
    private var movieCreditsResponse: CreditsResponse?
    private init() {}
    
    func getCredits(movieId: String, completionHandler: @escaping (Result<CreditsResponse, TaskError>) -> Void) {
        let filePath = Bundle(for: type(of: self)).path(forResource: "CreditsResponse", ofType: "json")
        DummyJsonProcess.shared.processDummyJsonResponse(filePath: filePath) {(result: Result<CreditsResponse, TaskError>) in
            switch result {
            case .success(let response, _):
                self.movieCreditsResponse = response
            case .failure:
                break
            }
        }
    }
    
    func getMovieResonse() -> CreditsResponse? {
        return movieCreditsResponse
    }
    
}
