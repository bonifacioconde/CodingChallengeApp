//
//  SearchSpec.swift
//  CodingChallengeAppTests
//
//  Created by Bonz Condz on 15/04/2020.
//  Copyright © 2020 Boni. All rights reserved.
//

import Quick
import Nimble
@testable
import CodingChallengeApp
import Moya

class SearchSpec: QuickSpec {
  
  override func spec() {
    
    var provider: MoyaProvider<SearchService>!
    var integrationTestPlugin: ServiceMockPlugin!
    var expectResult: AlbumResult!

    describe("The 'API Test'") {
      context("Search service") {
        ///
        afterEach {
          provider = nil
          integrationTestPlugin = nil
          expectResult = nil
        }
        
        ///
        beforeEach {
          integrationTestPlugin = ServiceMockPlugin()
          provider = MoyaProvider<SearchService>(endpointClosure: integrationTestPlugin.customEndpointClosure, stubClosure: MoyaProvider.immediatelyStub, plugins: [integrationTestPlugin])
          let parameters = ParameterBuilder()
            .add(value: "star", for: SearchKey.term)
            .add(value: "au", for: SearchKey.country)
            .add(value: "movie", for: SearchKey.media)
            .limit("40")
            .build()
          provider.request(SearchService.search(parameters: parameters)) { (result) in
            switch result {
            case .success(let response):
              do {
                let data = try response.map(AlbumResult.self)
                  expectResult = data
              } catch { }
            case .failure: break
            }
          }
        }
        
        ///
        it("should have results") {
          expect(expectResult).toNot(beNil())
        }
      }
    }
  }
}
