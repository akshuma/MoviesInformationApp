//
//  EnvironmentTest.swift
//  MoviesInformationAppTests
//
//  Created by Akshuma Trivedi on 04/07/21.
//

import XCTest
@testable import MoviesInformationApp

class EnvironmentTest: XCTestCase {
    
    override func setUpWithError() throws {
        super.setUp()
    }
    
    func test_serverEndPointUrl_ForDev() {
        //Arrange
        let serverEndPontUrl = Environment.serverEndPoint
        //Assert
        XCTAssertEqual("api.themoviedb.org", serverEndPontUrl)
    }
    
    func test_ApiKey_ForDev() {
        //Arrange
        let apiKey = Environment.apiKey
        //Assert
        XCTAssertEqual("b2925155642c384d5f9c26a2d4d9e103", apiKey)
    }
    
    func test_ApiVersion_ForDev() {
        //Arrange
        let apiVersion = Environment.apiVersion
        //Assert
        XCTAssertEqual("3", apiVersion)
    }
    
    override func tearDownWithError() throws {
        super.tearDown()
    }

}
