//
//  CreditsResponse.swift
//  MoviesInformationApp
//
//  Created by Akshuma Trivedi on 03/07/21.
//

import Foundation

struct CreditsResponse: Codable {
    let id: Int?
    let cast: [Cast]?
    let crew: [Cast]?
}

struct Cast: Codable {
    let adult: Bool?
    let gender, id: Int?
    let knownForDepartment, name, originalName: String?
    let popularity: Double?
    let profilePath: String?
    let castId: Int?
    let character, creditId: String?
    let order: Int?
}

extension CreditsResponse {
    var castAndCrewArray : [Cast]? {
        var castAndCrewArray: [Cast] = []
        castAndCrewArray.append(contentsOf: cast ?? [])
        castAndCrewArray.append(contentsOf: crew ?? [])
        return castAndCrewArray
    }
    
}
