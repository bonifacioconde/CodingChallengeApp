//
//  MasterControllerSpec.swift
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

class MasterControllerSpec: QuickSpec {
  
  override func spec() {
    
    var controller: MasterController!
    var viewModel: MasterViewModel!
    var dataSource: AlbumsDataSource!

    describe("The 'Master Controller Test'") {
      context("Can show screen") {
        ///
        afterEach {
          controller = nil
          viewModel = nil
          dataSource = nil
        }
        
        ///
        beforeEach {
          dataSource = AlbumsDataSource()
          viewModel = MasterViewModel(source: dataSource)
          controller = MasterController.instantiate(fromAppStoryboard: .main)
          controller.viewModel = viewModel
          viewModel.coordinatorDelegate = controller
          controller.tableView.dataSource = dataSource
        }
        
        it("should have 40 datas loaded") {
          expect(controller.tableView.numberOfRows(inSection: 0)).to(equal(40))
        }
      }
    }
  }
}
