//
//  UsersReviewsResponse.swift
//  MoviesInformationApp
//
//  Created by Akshuma Trivedi on 03/07/21.
//

import Foundation

struct UsersReviewsResponse: Codable {
    let id, page: Int?
    let results: [Reviews]?
    let totalPages, totalResults: Int?
}

struct Reviews: Codable {
    let author: String?
    let authorDetails: AuthorDetails?
    let content, createdAt, id, updatedAt: String?
    let url: String?

}

struct AuthorDetails: Codable {
    let name, username: String
    let avatarPath: String?
    let rating: Int?
    
}
