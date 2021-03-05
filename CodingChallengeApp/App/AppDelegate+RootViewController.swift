//
//  AppDelegate+RootViewController.swift
//  CodingChallengeApp
//
//  Created by Bonifacio Conde on 3/4/21.
//  Copyright © 2021 Boni. All rights reserved.
//

import UIKit

extension AppDelegate {
  func showRootMaster() {
    let mc = R.storyboard.main.masterController()!
    let source = AlbumsDataSource()
    let network = SearchNetwork(provider: SearchServiceProvider)
    let viewModel = MasterViewModel(source: source, network: network)
    mc.viewModel = viewModel
    let nav = UINavigationController(rootViewController: mc)
    window?.rootViewController = nav
  }
}
