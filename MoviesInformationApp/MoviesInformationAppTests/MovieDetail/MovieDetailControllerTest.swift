//
//  MovieDetailControllerTest.swift
//  MoviesInformationAppTests
//
//  Created by Akshuma Trivedi on 04/07/21.
//

import XCTest
@testable import MoviesInformationApp

class MovieDetailControllerTest: XCTestCase {
    var controller: MovieDetailViewController!
    
    var synoypsisResponse: SynoypsisResponse?
    var creditsResponse: CreditsResponse?
    var similarMoviesResponse: SimilarMoviesResponse?
    

    override func setUpWithError() throws {
        super.setUp()
        let mockSynoypsisRepo = MockSynoypsisRepository.shared
        let mockCreditsRepo = MockCreditsRepository.shared
        let mockSimilarMoviesRepo = MockSimilarMoviesRepository.shared
        
        let storyboard = UIStoryboard(name: "MovieDetail", bundle: nil)
        controller = (storyboard.instantiateViewController(identifier: "movieDetailViewController") as! MovieDetailViewController)
        controller.synoypsisRepository = mockSynoypsisRepo
        controller.movieCreditsRepository = mockCreditsRepo
        controller.similarMovieRepository = mockSimilarMoviesRepo
        controller.loadViewIfNeeded()
        
        synoypsisResponse = mockSynoypsisRepo.getSynoypsisResponse()
        
         
    }

    override func tearDownWithError() throws {
        super.tearDown()
        controller = nil
        synoypsisResponse = nil
        creditsResponse = nil
        similarMoviesResponse = nil
    }

    

}
