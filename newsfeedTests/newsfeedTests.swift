//
//  newsfeedTests.swift
//  newsfeedTests
//
//  Created by Nikita Levintsov on 08.02.21.
//

import XCTest
@testable import newsfeed

class newsfeedTests: XCTestCase {


    
    func testCreateURLWithRightParameters() throws {
        let everything = GoogleNewsEverythingRequest(topic: "COVID-19", dateFrom: "2021-02-07", dateTo: "2021-02-07", sortCriteria: .popularity)
       let urlCreator = URLCreator(baseUrl: "https://newsapi.org", apiKey: "e56c97e0c2344aa2817396a7f2deb097", version: "/v2/")
        
        let result = urlCreator.createURL(endpoint: Endpoints.everything, queryItems: everything)
        let comparedResult = URL(string: "https://newsapi.org/v2/everything?q=COVID-19&from=2021-02-07&to=2021-02-07&sortBy=popularity&apiKey=e56c97e0c2344aa2817396a7f2deb097")
        XCTAssertEqual(result, comparedResult
                       , "cannot create right URL, mistake in creating")
    }
    
    func testCreateQueryItemsForEverythingRequest() throws {
        
    }

}
