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
    
    var provider: MoyaProvider<LookupService>!
    var integrationTestPlugin: ServiceMockPlugin!
    var expectResult: Album!

    describe("The 'API Test'") {
      context("Lookup service") {
        ///
        afterEach {
          provider = nil
          integrationTestPlugin = nil
          expectResult = nil
        }
        
        ///
        beforeEach {
          integrationTestPlugin = ServiceMockPlugin()
          provider = MoyaProvider<LookupService>(endpointClosure: integrationTestPlugin.customEndpointClosure, stubClosure: MoyaProvider.immediatelyStub, plugins: [integrationTestPlugin])
          let parameter = ParameterBuilder().add(value: "1", for: LookupKey.id).build()
          provider.request(LookupService.lookup(parameters: parameter)) { (result) in
            switch result {
            case .success(let response):
              do {
                let data = try response.map(AlbumResult.self)
                
                if let lookUpAlbum = Array(
                  data.results.compactMap({ $0 })
                ).first {
                  expectResult = lookUpAlbum
                }
                
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

