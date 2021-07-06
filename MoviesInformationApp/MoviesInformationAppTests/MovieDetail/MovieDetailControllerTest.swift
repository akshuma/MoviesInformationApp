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
        creditsResponse = mockCreditsRepo.getCreditsResponse()
        similarMoviesResponse = mockSimilarMoviesRepo.getSimilarMoviesResponse()
         
    }
    
    func test_movieDetail_noOfSection()  {
        //Arrange
        let sections = controller.dataSource.numberOfSections(in: controller.movieDetailTableView)
        //Assert
        XCTAssertEqual(sections, 4)
    }
   
    func test_movieDetail_noOfRowsInSection()  {
        //Arrange
        let rows = controller.dataSource.tableView(controller.movieDetailTableView, numberOfRowsInSection: 0)
        //Assert
        XCTAssertEqual(rows, 1)
    }
    //MARK: - Synoypsis Cell
    func test_InSynoypsisCell_movieNameLabelText() {
        //Arrange
        let movieTitleLabelText = getSynoypsisCell().movieNameLabel.text
        let movieTitle = synoypsisResponse?.originalTitle
        //Assert
        XCTAssertEqual(movieTitle, movieTitleLabelText)
        
    }
    
    func test_InSynoypsisCell_releaseDateLabelText() {
        //Arrange
        let movieReleaseDate = getSynoypsisCell().movieReleaseDate.text
        let datebefore = synoypsisResponse?.releaseDate ?? ""
        let date = String.convertDateToStringUsingTimeStamp(datebefore, dateFormat: DateFormat.movieListing.rawValue)
        //Assert
        XCTAssertEqual(movieReleaseDate, date)
        
    }
    
    func test_ratingViewRateText_InSynoypsisCell() {
        //Arrange
        let movieCellRate = getSynoypsisCell().ratingView.rating
        let rating = Double(synoypsisResponse?.voteAverage ?? 0)
        //Assert
        XCTAssertEqual(movieCellRate, rating)
        
    }
    
    func test_overViewLabelText_InSynoypsisCell() {
        //Arrange
        let overViewLabelText = getSynoypsisCell().overViewlabel.text ?? ""
        let overView = synoypsisResponse?.overview ?? ""
        //Assert
        XCTAssertEqual(overViewLabelText, overView)
        
    }
    //MARK: - Cast Cell
   /* func test_headerTextFor_castMovieContainerCell() {
        //Arrange
        let headerTextCell = getMovieContainerCell(1).headerTitleLabel.text ?? ""
        //Assert
        XCTAssertEqual(headerTextCell, "Cast & Crew")
        
    }
    
    //MARK: - Similar Movie Cell
    func test_headerTextFor_SimilarMovieContainerCell() {
        //Arrange
        let headerTextCell = getMovieContainerCell(3).headerTitleLabel.text ?? ""
        //Assert
        XCTAssertEqual(headerTextCell, "You might also like")
        
    }*/

    override func tearDownWithError() throws {
        super.tearDown()
        controller = nil
        synoypsisResponse = nil
        creditsResponse = nil
        similarMoviesResponse = nil
    }


}
extension MovieDetailControllerTest {
    func getSynoypsisCell() -> MovieSynoypsisTableViewCell {
        return controller.dataSource.tableView(controller.movieDetailTableView, cellForRowAt: IndexPath(row: 0, section: 0))
            as! MovieSynoypsisTableViewCell
    }
        
    func getMovieContainerCell(_ section: Int) -> MoviesContainerTableViewCell {
        return controller.dataSource.tableView(controller.movieDetailTableView, cellForRowAt: IndexPath(row: 0, section: section))
            as! MoviesContainerTableViewCell
    }
    
}
