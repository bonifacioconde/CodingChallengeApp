//
//  MasterControllerTests.swift
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

class MasterControllerTests: QuickSpec {
  
  override func spec() {

    describe("MasterController'") {
      var vc: MasterController!
      var navigationController: UINavigationController!
      var vm: MasterViewModel!
      var dataSource: AlbumsDataSource!
      
      context("when view is loaded") {
        ///
        afterEach {
//          vc = nil
//          navigationController = nil
//          vm = nil
//          dataSource = nil
        }
        
        ///
        beforeEach {
          vc = R.storyboard.main.masterController()!
          dataSource = AlbumsDataSource()
          vm = MasterViewModel(source: dataSource)
          vc.viewModel = vm
          navigationController = UINavigationController(rootViewController: vc)
          _ = vc.view
          vc.loadViewIfNeeded()
        }
        
        it("should have non-nil properties") {
          expect(vc.tableView).toNot(beNil())
        }
        
        it("should have 40 datas loaded") {
          expect(
            vc.tableView.numberOfRows(inSection: 0))
            .to(equal(40)
          )
        }
        
        
        it("should present DetailController on row selected") {
          let tableView = vc.tableView
          let indexPath = IndexPath(row: 0, section: 0)

          vc.tableView(tableView!, didSelectRowAt: indexPath)
          expect(navigationController.viewControllers.last)
            .toEventually(
              beAKindOf(DetailController.self)
          )
        }
      }
    }
  }
}
