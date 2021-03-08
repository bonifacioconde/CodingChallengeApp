//
//  MasterViewModelTests.swift
//  CodingChallengeAppTests
//
//  Created by Bonifacio Conde on 3/5/21.
//  Copyright © 2021 Boni. All rights reserved.
//

import Quick
import Nimble
@testable
import CodingChallengeApp

class MasterViewModelTests: QuickSpec {
  override func spec() {

    describe("MasterViewModel'") {
      var vm: MasterViewModel!
      var dataSource: AlbumsDataSource!
      
      beforeEach {
        dataSource = AlbumsDataSource()
        vm = MasterViewModel(source: dataSource)
        
      }
      
      it("must call setupData and datasource will have data") {
        expect(dataSource.data.count).to(equal(0))
        vm.setupData()
        expect(dataSource.data.count).toNot(equal(0))
      }
    }
  }
}
