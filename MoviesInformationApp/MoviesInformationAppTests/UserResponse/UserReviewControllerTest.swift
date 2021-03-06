//
//  UserReviewControllerTest.swift
//  MoviesInformationAppTests
//
//  Created by Akshuma Trivedi on 04/07/21.
//

import XCTest
@testable import MoviesInformationApp


class UserReviewControllerTest: XCTestCase {
    
    var controller: UserReviewViewController!
    var userReviewResponse: UsersReviewsResponse?
    
    override func setUpWithError() throws {
        super.setUp()
        let mockRepository = MockUsersReviewsRepository.shared
        let storyboard = UIStoryboard(name: "UserReview", bundle: nil)
        controller = (storyboard.instantiateViewController(identifier: "UserReviewViewController") as! UserReviewViewController)
        controller.useReviewsRepository = mockRepository
        controller.movieId = 123
        controller.loadViewIfNeeded()
        userReviewResponse = mockRepository.getUsersReviewsResponse()
    }
    
    func test_userReview_noOfrows()  {
        //arrange
        let count = userReviewResponse?.results?.count
        //assert
        XCTAssertEqual(count, 3)
    }
    
    func test_userReview_authoreNameLabel_equalTest()  {
        //arrange
        let userReview = userReviewResponse?.results?.first ?? nil
        let cellAutherName = getTableViewCell().authorNameLabel.text
        //assert
        XCTAssertEqual(userReview?.author, cellAutherName)
    }
    
    func test_userReview_authoreNameLabel_notEqualTest()  {
        //arrange
        let cellAutherName = getTableViewCell().authorNameLabel.text
        //assert
        XCTAssertNotEqual("abc", cellAutherName)
    }
    
    func test_userReview_dateLabel_equalTest()  {
        //arrange
        let userReview = userReviewResponse?.results?.first ?? nil
        let commentDate = "@\(userReview?.authorDetails?.username ?? "") \n\(String.convertDateToStringUsingTimeStamp(userReview?.createdAt ?? "", dateFormat: DateFormat.userReview.rawValue))"
        let cellDateLabel = getTableViewCell().dateLabel.text
        //assert
        XCTAssertEqual(commentDate, cellDateLabel)
    }
    
    func test_userReview_dateLabel_notEqualTest()  {
        //arrange
        let cellDateLabel = getTableViewCell().dateLabel.text
        //assert
        XCTAssertNotEqual("abc", cellDateLabel)
    }
    
    func test_userReview_ratingViewRate_equalTest()  {
        //Arrange
        let userReviewcell = getTableViewCell().ratingView.rating
        let userReview = Double(userReviewResponse?.results?.first?.authorDetails?.rating ?? 0)
        //assert
        XCTAssertEqual(userReviewcell, userReview)
    }
    
    func test_userReview_ratingViewRate_notEqualTest()  {
        //arrange
        let cellRatingView = getTableViewCell().ratingView.rating
        //assert
        XCTAssertNotEqual(cellRatingView, 123.2)
    }
    
    func test_userReview_overViewLabel_equalTest()  {
        //arrange
        let userReview = userReviewResponse?.results?.first ?? nil
        let content = userReview?.content
        let cellContentLabel = getTableViewCell().contentLabel.text
        //assert
        XCTAssertEqual(cellContentLabel, content)
    }
    
    func test_userReview_overViewLabel_notEqualTest()  {
        //arrange
        let cellContentLabel = getTableViewCell().contentLabel.text
        //assert
        XCTAssertNotEqual(cellContentLabel, "wasd")
    }
    
    override func tearDownWithError() throws {
        super.tearDown()
        controller = nil
        userReviewResponse = nil
    }
    
}

extension UserReviewControllerTest {
    func getTableViewCell() -> UserReviewTableViewCell {
        return controller.dataSource.tableView(controller.userReviewTableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! UserReviewTableViewCell
    }
}
