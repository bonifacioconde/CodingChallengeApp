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
    describe("The 'API Test'") {
      var expectResult: AlbumResult!
      var network: MockSearchNetwork!
      
      context("Search service") {
        ///
        afterEach {
          network = nil
          expectResult = nil
        }
        
        ///
        beforeEach {
          network = MockSearchNetwork()
          let parameters = ParameterBuilder()
            .add(value: "star", for: SearchKey.term)
            .add(value: "au", for: SearchKey.country)
            .add(value: "movie", for: SearchKey.media)
            .limit("40")
            .build()
          
          network.list(
            with: parameters,
            complete: { data in
              expectResult = data
            },
            fail: { _ in 
            }
          )
        }
        
        ///
        it("should have results") {
          expect(expectResult).toNot(beNil())
        }
      }
    }
  }
}
