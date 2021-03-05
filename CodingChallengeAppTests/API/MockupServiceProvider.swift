//
//  File.swift
//  CodingChallengeAppTests
//
//  Created by Bonifacio Conde on 3/5/21.
//  Copyright © 2021 Boni. All rights reserved.
//

import Quick
import Nimble
@testable
import CodingChallengeApp
import Moya

class MockLookupServiceProvider: LookupNetwork {
  init(plugin: ServiceMockPlugin = ServiceMockPlugin()) {
    super.init(provider: MoyaProvider<LookupService>(
      endpointClosure: plugin.customEndpointClosure,
      stubClosure: MoyaProvider.immediatelyStub,
      plugins: [plugin]
    ))
  }
}

class MockSearchServiceProvider: SearchNetwork {
  init(plugin: ServiceMockPlugin = ServiceMockPlugin()) {
    super.init(provider: MoyaProvider<SearchService>(
      endpointClosure: plugin.customEndpointClosure,
      stubClosure: MoyaProvider.immediatelyStub,
      plugins: [plugin]
    ))
  }
}
