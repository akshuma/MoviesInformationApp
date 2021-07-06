//
//  MovieListingViewControllerTest.swift
//  MoviesInformationAppTests
//
//  Created by Akshuma Trivedi on 04/07/21.
//

import XCTest
@testable import MoviesInformationApp

class MovieListingViewControllerTest: XCTestCase {
    var controller: MovieListViewController!
    var movieListResponse: MovieListResponse?

    override func setUp() {
        super.setUp()
        let mockRepository = MockMovieListingRepository.shared
        let storyboard = UIStoryboard(name: "MovieList", bundle: nil)
        controller = (storyboard.instantiateViewController(identifier: "movieListViewController") as! MovieListViewController)
        controller.movieListingRepository = mockRepository
        controller.loadViewIfNeeded()
       // controller.getPlayingMovies(pageNo: 1)
        movieListResponse = mockRepository.getMovieResonse()
       
    }
    
    func test_movieList_noOfRows_inTableView() {
        //arrange
        let count = movieListResponse?.results?.count
        //assert
        XCTAssertEqual(count, 10)
    }
    
    func test_movieListCell_moiveName_equal() {
        //arrange
        let cellMovieName = getMovieTableViewCell().movieNameLabel.text ?? ""
        let moviedata = movieListResponse?.results?.first?.title ?? ""
        //assert
        XCTAssertEqual(cellMovieName, moviedata)
    }
    
    func test_movieList_moiveName_notEqual() {
        //arrange
        let cellMovieName = getMovieTableViewCell().movieNameLabel.text
        let movieName = "hello"
        //assert
        XCTAssertNotEqual(cellMovieName, movieName, "test case fail because moive name is equal")
    }
    
    func test_movieListCell_movieReleaseDate_equal() {
        //Arrange
        let movieReleaseDate = getMovieTableViewCell().movieReleaseDate.text
        let moviedata = movieListResponse?.results?.first ?? nil
        let datebefore = moviedata?.releaseDate ?? ""
        let date = String.convertDateToStringUsingTimeStamp(datebefore, dateFormat: DateFormat.movieListing.rawValue)
        //Assert
        XCTAssertEqual(date, movieReleaseDate, "test case fail because moive relese date is not equal")
    }
    
    func test_movieListCell_movieReleaseDate_notEqual() {
        //Arrange
        let movieReleaseDate = getMovieTableViewCell().movieReleaseDate.text
        let date = "abcd"
        //Assert
        XCTAssertNotEqual(date, movieReleaseDate, "test case fail because moive relese date is not equal")
    }
    
    func test_movieListCell_movieRatingViewrate_equal() {
        //Arrange
        let movieCellRate = getMovieTableViewCell().ratingView.rating
        let rating = Double(movieListResponse?.results?.first?.voteAverage ?? 0)
        //Assert
        XCTAssertEqual(rating, movieCellRate, "test case fail because moive rating date is not equal")
    }
    
    func test_movieListCell_movieRatingViewrate_notEqual() {
        //Arrange
        let movieCellRate = getMovieTableViewCell().ratingView.rating
        let rating = 1.0
        //Assert
        XCTAssertNotEqual(rating, movieCellRate, "test case fail because moive rating date is equal")
    }

    override func tearDownWithError() throws {
        super.tearDown()
        controller = nil
        movieListResponse = nil
    
    }

}
extension MovieListingViewControllerTest {
    func getMovieTableViewCell() -> MovieListTableViewCell {
        return controller.dataSource.tableView(controller.movieTableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! MovieListTableViewCell
    }
}
