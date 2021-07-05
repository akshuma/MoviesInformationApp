//
//  MockSynoypsisRepository.swift
//  MoviesInformationAppTests
//
//  Created by Akshuma Trivedi on 04/07/21.
//

import Foundation
@testable import MoviesInformationApp

class MockSynoypsisRepository: SynoypsisRepositoryProtocol {
    static let shared = MockSynoypsisRepository()
    private var movieSynoypsisResponse: SynoypsisResponse?
    private init() {}
    
    func getSynoypsis(movieId: String, completionHandler: @escaping (Result<SynoypsisResponse, TaskError>) -> Void) {
        let filePath = Bundle(for: type(of: self)).path(forResource: "SynoypsisResponse", ofType: "json")
        DummyJsonProcess.shared.processDummyJsonResponse(filePath: filePath) {(result: Result<SynoypsisResponse, TaskError>) in
            switch result {
            case .success(let response, _):
                self.movieSynoypsisResponse = response
            case .failure:
                break
            }
        }
    }
    

    func getSynoypsisResponse() -> SynoypsisResponse? {
        return movieSynoypsisResponse 
    }
    
    
}
