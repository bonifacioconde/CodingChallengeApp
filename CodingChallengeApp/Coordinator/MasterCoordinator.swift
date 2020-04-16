//
//  MasterCoordinator.swift
//  CodingApp
//
//  Created by Boni on 10/8/19.
//  Copyright © 2019 Boni. All rights reserved.
//

import UIKit

class MasterCoordinator: Coordinator {
    var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        let navVC = AppNavigationController.instantiate(fromAppStoryboard: .main)
        
        
        //let vc = MasterViewController.instantiate(fromAppStoryboard: .main)
        //masterViewModel.coordinatorDelegate = self
        //vc.viewModel = masterViewModel
        //(navVC.viewControllers.first as? MasterViewController)?.viewModel = masterViewModel
        
        self.window?.rootViewController = navVC
    }
}

extension MasterCoordinator: MasterViewCoordinatorDelegate {
    func showDetail(from album: Album?) {
        guard
          let album = album,
          let rootNav = self.window?.rootViewController as? UINavigationController
          else { return }
        let detailCoordinator = DetailCoordinator(album: album, navigationController: rootNav)
        detailCoordinator.start()
    }
}
