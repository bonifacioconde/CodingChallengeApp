//
//  CodingChallengeAppTests.swift
//  CodingChallengeAppTests
//
//  Created by Bonz Condz on 14/04/2020.
//  Copyright © 2020 Boni. All rights reserved.
//

@testable import Moya

import XCTest

class APITests: XCTestCase {

    var provider: MoyaProvider<SearchService>!

    override func setUp() {
        super.setUp()

        // A mock provider with a mocking `endpointClosure` that stub immediately
        provider = MoyaProvider<SearchService>(endpointClosure: customEndpointClosure, stubClosure: MoyaProvider.immediatelyStub)
    }

    func customEndpointClosure(_ target: SearchService) -> Endpoint {
        return Endpoint(url: URL(target: target).absoluteString,
                        sampleResponseClosure: { .networkResponse(200, target.testSampleData) },
                        method: target.method,
                        task: target.task,
                        httpHeaderFields: target.headers)
    }
  
  func testExample() {
      // This is an example of a functional test case.
      // Use XCTAssert and related functions to verify your tests produce the correct results.
    provider.
  }

}

extension SearchService {
    var testSampleData: Data {
        switch self {
        case .search:
            // Returning all-popular-movies.json
            let url = Bundle(for: APITests.self).url(forResource: "search", withExtension: "json")!
            return try! Data(contentsOf: url)
        }
    }
}
