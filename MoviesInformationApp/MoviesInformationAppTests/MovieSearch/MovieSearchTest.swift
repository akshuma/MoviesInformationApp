//
//  MovieSearchTest.swift
//  MoviesInformationAppTests
//
//  Created by Akshuma Trivedi on 07/07/21.
//

import XCTest
@testable import MoviesInformationApp

class MovieSearchTest: XCTestCase {

    override func setUpWithError() throws {
       
    }

    func test_searchAlgo_filterMovie_usingWord()  {
        //arrange
        let array = ["dilwale", "dil", "milege milege", "man", "love"]
        let result = ["dilwale", "dil"]
        let filterResult = filterSearchByAlgo(sourceArray: array, query: "dil")
        XCTAssertEqual(result, filterResult)
    }
    
    func test_searchAlgo_filterMovie_usingSingleLatter()  {
        //arrange
        let array = ["dilwale", "dil", "milege milege", "man", "love", "dil hi dil main"]
        let result = ["milege milege", "man", "dil hi dil main"]
        let filterResult = filterSearchByAlgo(sourceArray: array, query: "m")
        XCTAssertEqual(result, filterResult)
    }
    
    func test_searchAlgo_filterMovie_usingSingleLatterNotEqual()  {
        //arrange
        let array = ["dilwale", "dil", "milege milege", "man", "love", "dil hi dil main"]
        let result = ["dil"]
        let filterResult = filterSearchByAlgo(sourceArray: array, query: "m")
        XCTAssertNotEqual(result, filterResult)
    }
    
    func test_searchAlgo_filterMovie_usingReverseString()  {
        //arrange
        let array = ["dilwale", "dil", "milege milege", "man", "love", "dil hi dil main"]
        let result = ["dil hi dil main"]
        let filterResult = filterSearchByAlgo(sourceArray: array, query: "main dil hi dil")
        XCTAssertEqual(result, filterResult)
    }
    
    func test_searchAlgo_filterMovie_usingReverseStringNotequal()  {
        //arrange
        let array = ["dilwale", "dil", "milege milege", "man", "love", "dil hi dil main"]
        let result = ["dil hi dil main"]
        let filterResult = filterSearchByAlgo(sourceArray: array, query: "man")
        XCTAssertNotEqual(result, filterResult)
    }
    
    override func tearDownWithError() throws {
        
    }

    func filterSearchByAlgo(sourceArray: [String], query: String) -> [String] {
        var list: [String] = []
        for sourceObject in sourceArray {
            if sourceObject.searchMovie(query) {
                list.append(sourceObject)
            }
        }
        return list
    }
}
