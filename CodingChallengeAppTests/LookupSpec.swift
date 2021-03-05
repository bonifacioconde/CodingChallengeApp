//
//  LookupSpec.swift
//  CodingChallengeAppTests
//
//  Created by Bonz Condz on 16/04/2020.
//  Copyright © 2020 Boni. All rights reserved.
//

import Quick
import Nimble
@testable
import CodingChallengeApp
import Moya

class LookupSpec: QuickSpec {
  
  override func spec() {
    
    var network: MockLookupNetwork!
    var expectResult: Album!

    describe("The 'API Test'") {
      context("Lookup service") {
        ///
        afterEach {
          network = nil
          expectResult = nil
        }
        
        ///
        beforeEach {
          network = MockLookupNetwork()
          let parameter = ParameterBuilder()
            .add(value: "1", for: LookupKey.id)
            .build()
          network.show(with: parameter, success: { data in
            if let lookUpAlbum = Array(
              data.results.compactMap({ $0 })
            ).first {
              expectResult = lookUpAlbum
            }
          }, failure: {
            
          })
        }
        
        ///
        it("should have results") {
          expect(expectResult).toNot(beNil())
        }
      }
    }
  }
}
