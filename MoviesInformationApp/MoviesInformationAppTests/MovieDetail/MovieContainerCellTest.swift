//
//  MovieContainerCellTest.swift
//  MoviesInformationAppTests
//
//  Created by Akshuma Trivedi on 06/07/21.
//

import XCTest
@testable import MoviesInformationApp

class MovieContainerCellTest: XCTestCase {
    var controller: MovieDetailViewController!
    
    var creditsResponse: CreditsResponse?
    var similarMoviesResponse: SimilarMoviesResponse?
    
    override func setUpWithError() throws {
        super.setUp()
        let mockCreditsRepo = MockCreditsRepository.shared
        let mockSimilarMoviesRepo = MockSimilarMoviesRepository.shared
        
        let storyboard = UIStoryboard(name: "MovieDetail", bundle: nil)
        controller = (storyboard.instantiateViewController(identifier: "movieDetailViewController") as! MovieDetailViewController)
        controller.movieId = 123
        controller.movieCreditsRepository = mockCreditsRepo
        controller.similarMovieRepository = mockSimilarMoviesRepo
        controller.loadViewIfNeeded()
        similarMoviesResponse = mockSimilarMoviesRepo.getSimilarMoviesResponse()
        creditsResponse = mockCreditsRepo.getCreditsResponse()
    }
    
    
    func test_creditCollection_noOfRows()  {
        let cellItem = getMovieContainerCell(1).movieCollectionView.numberOfItems(inSection: 0)
        //Assert
        XCTAssertEqual(cellItem, 3)
    }
    
    func test_creditCollection_AutherNameText()  {
        let name = getMoviecreditsCollectionCell().castNameLabel.text ?? ""
        let responseName = creditsResponse?.castAndCrewArray?.first?.name
        //Assert
        XCTAssertEqual(name, responseName)
    }
    
    func test_similarMoviewCollection_movieNameText()  {
        let name = getMovieSimlarCollectionCell().movieNameLabel.text ?? ""
        let responseName = similarMoviesResponse?.results.first?.originalTitle ?? ""
        
        //Assert
        XCTAssertEqual(name, responseName)
    }
    
    override func tearDownWithError() throws {
        super.tearDown()
        controller = nil
        creditsResponse = nil
        similarMoviesResponse = nil
    }
    
}

extension MovieContainerCellTest {
    func getMovieContainerCell(_ section: Int) -> MoviesContainerTableViewCell {
        return controller.dataSource.tableView(controller.movieDetailTableView, cellForRowAt: IndexPath(row: 0, section: section))
            as! MoviesContainerTableViewCell
    }
    
    func getMoviecreditsCollectionCell() -> CreditsCollectionViewCell {
        let collectionView = getMovieContainerCell(1)
        collectionView.containerIdentifier = ContainerIdenifier.cast
        return collectionView.movieCollectionView.dataSource?.collectionView(collectionView.movieCollectionView, cellForItemAt: IndexPath(item: 0, section: 0))
            as! CreditsCollectionViewCell
    }
    
    func getMovieSimlarCollectionCell() -> SimilarMoviesCollectionViewCell {
        let collectionView = getMovieContainerCell(3)
        collectionView.containerIdentifier = ContainerIdenifier.cast
        return collectionView.movieCollectionView.dataSource?.collectionView(collectionView.movieCollectionView, cellForItemAt: IndexPath(item: 0, section: 0))
            as! SimilarMoviesCollectionViewCell
        
    }
}
