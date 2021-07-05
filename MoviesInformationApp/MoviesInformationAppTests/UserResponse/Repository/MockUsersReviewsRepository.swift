//
//  MockUsersReviewsRepository.swift
//  MoviesInformationAppTests
//
//  Created by Akshuma Trivedi on 04/07/21.
//

import Foundation
@testable import MoviesInformationApp

class MockUsersReviewsRepository: UsersReviewsRepositoryProtocol {
    static let shared = MockUsersReviewsRepository()
    private var movieUsersReviewsResponse: UsersReviewsResponse?
    private init() {}
    
    func getCustomerReviews(moiveId: String, pageNo: Int, completionHandler: @escaping (Result<UsersReviewsResponse, TaskError>) -> Void) {
        let filePath = Bundle(for: type(of: self)).path(forResource: "UsersReviewsReponse", ofType: "json")
        DummyJsonProcess.shared.processDummyJsonResponse(filePath: filePath) {(result: Result<UsersReviewsResponse, TaskError>) in
            switch result {
            case .success(let response, _):
                self.movieUsersReviewsResponse = response
            case .failure:
                break
            }
        }
    }

    func getMovieResonse() -> UsersReviewsResponse? {
        return movieUsersReviewsResponse
    }
    
    
}
