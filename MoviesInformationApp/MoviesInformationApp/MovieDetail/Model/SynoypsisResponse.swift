//
//  SynoypsisResponse.swift
//  MoviesInformationApp
//
//  Created by Akshuma Trivedi on 03/07/21.
//

import Foundation

struct SynoypsisResponse: Codable {
    let backdropPath: String?
    let budget: Int?
    let homepage: String?
    let id: Int
    let imdbId, originalLanguage, originalTitle, overview: String?
    let popularity: Double
    let posterPath: String?
    let releaseDate: String?
    let revenue, runtime: Int
    let status, tagline, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
}
