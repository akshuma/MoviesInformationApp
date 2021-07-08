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

extension MovieListResponse {
    func filterMovieList( _ query: String) -> [Movies] {
        var movieList: [Movies] = []
        guard
            let results = results  else {return [] }
        results.forEach({ (movie) in
            guard let movieTitle = movie.title else {return}
            if movieTitle.searchMovie(query) {
                movieList.append(movie)
            }
        })
        return movieList
    }
}
