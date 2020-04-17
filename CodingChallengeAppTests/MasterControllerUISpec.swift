//
//  MasterControllerUISpec.swift
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

class MasterControllerUISpec: QuickSpec {
  
  override func spec() {
    
    var controller: MasterController!
    var navigationController: UINavigationController!
    var provider: MoyaProvider<SearchService>!
    var integrationTestPlugin: ServiceMockPlugin!

    describe("The 'Master Controller Test'") {
      context("Can show screen") {
        ///
        afterEach {
          controller = nil
          navigationController = nil
          provider = nil
          integrationTestPlugin = nil
        }
        
        ///
        beforeEach {
          integrationTestPlugin = ServiceMockPlugin()
          provider = MoyaProvider<SearchService>(endpointClosure: integrationTestPlugin.customEndpointClosure, stubClosure: MoyaProvider.immediatelyStub, plugins: [integrationTestPlugin])
          controller = MasterController.instantiate(fromAppStoryboard: .main)
          navigationController = UINavigationController(rootViewController: controller)
          _ = controller.view
          let source = AlbumsDataSource()
          let network = SearchNetwork(provider: provider)
          controller.viewModel = MasterViewModel(source: source, network: network)
          controller.viewModel.coordinatorDelegate = controller
        }
        
        it("should have 40 datas loaded") {
          expect(
            controller.tableView.numberOfRows(inSection: 0))
            .to(equal(40)
          )
        }
        
        it("row is selected") {
          let tableView = controller.tableView
          let indexPath = IndexPath(row: 0, section: 0)

          controller.tableView(tableView!, didSelectRowAt: indexPath)
          expect(navigationController.viewControllers.last)
            .toEventually(
              beAKindOf(DetailController.self)
          )
        }
      }
    }
  }
}
