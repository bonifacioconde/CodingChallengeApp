//
//  CodingChallengeAppTests.swift
//  CodingChallengeAppTests
//
//  Created by Bonz Condz on 14/04/2020.
//  Copyright © 2020 Boni. All rights reserved.
//

@testable import Moya
@testable import CodingChallengeApp
import XCTest

//let expectation = self.expectation(description: "Execute the call related to functionality X")

class IntegrationTestMockPlugin: PluginType {
  
  func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
    
    guard let apiTarget = target as? SearchService, case .search = apiTarget else {
      XCTFail("did hit an unexpected target")
      return
    }
    //        expectation?.fulfill()
  }
}

class APITests: XCTestCase {
  
  var provider: MoyaProvider<SearchService>!
  let integrationTestPlugin = IntegrationTestMockPlugin()
  
  override func setUp() {
    super.setUp()
    
    // A mock provider with a mocking `endpointClosure` that stub immediately
    provider = MoyaProvider<SearchService>(endpointClosure: customEndpointClosure, stubClosure: MoyaProvider.immediatelyStub, plugins: [integrationTestPlugin])
  }
  
  func testIntegration() {
    // execute your app’s functionality, and by the time it is expected to be completed, just run:
    let parameters = ParameterBuilder()
      .add(value: "star", for: SearchKey.term)
      .add(value: "au", for: SearchKey.country)
      .add(value: "movie", for: SearchKey.media)
      .limit("40")
      .build()
    let service = SearchService.search(parameters: parameters)
    var expectResult: AlbumResult?
    provider.request(service) { (result) in
      switch result {
      case let .success(response):
          do {
              let data = try response.map(AlbumResult.self)
              expectResult = data
          } catch let error {
              //failure?(PresentableError(message: error.localizedDescription))
          }

      case let .failure(error): break
          //failure?(PresentableError(message: error.localizedDescription))
      }
      XCTAssert(expectResult != nil)
    }
    
  }
  
}
