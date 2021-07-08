//
//  UsersReviewsRepository.swift
//  MoviesInformationApp
//
//  Created by Akshuma Trivedi on 03/07/21.
//

import UIKit

protocol UsersReviewsRepositoryProtocol {
    func getCustomerReviews(moiveId: String, pageNo: Int, completionHandler: @escaping(Result<UsersReviewsResponse, TaskError>) -> Void)
}

class UsersReviewsRepository: UsersReviewsRepositoryProtocol {
    static let shared = UsersReviewsRepository()
    private init() { }
    
    // get userReviews data from getCustomerReviews Api accroeding to MovieId
    func getCustomerReviews(moiveId: String, pageNo: Int, completionHandler: @escaping (Result<UsersReviewsResponse, TaskError>) -> Void) {
        let task = HTTPTask()
        task.GET(api: MoviesApis.usersReviews(movieId: moiveId, pageNo: pageNo)) { (result: Result<UsersReviewsResponse, TaskError>) in
            DispatchQueue.main.async {
                completionHandler(result)
            }
        }
    }
    

}
