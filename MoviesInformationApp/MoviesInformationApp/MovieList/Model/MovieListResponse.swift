//
//  MovieListResponse.swift
//  MoviesInformationApp
//
//  Created by Akshuma Trivedi on 03/07/21.
//

import Foundation

struct MovieListResponse: Codable {
    let page: Int?
    let results: [Movies]?
    let totalPages: Int?
    let totalResults: Int?
}

struct Movies: Codable {
    let id: Int64?
    let title: String?
    let overview: String?
    let voteAverage: Double?
    let voteCount: Double?
    let posterPath: String?
    let releaseDate: String?
}

// MARK: - Dates
struct Dates: Codable {
    let maximum, minimum: String?
}
