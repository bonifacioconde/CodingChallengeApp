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
        let vc = MasterViewController.instantiate(fromAppStoryboard: .main)
        let masterViewModel = MasterViewModel()
        masterViewModel.coordinatorDelegate = self
        vc.viewModel = masterViewModel
        let navVC = UINavigationController(rootViewController: vc)
        self.window?.rootViewController = navVC
    }
}

extension MasterCoordinator: MasterViewCoordinatorDelegate {
    func showDetail(from album: Album?) {
        guard let album = album else { return }
        let detailCoordinator = DetailCoordinator(album: album, navigationController: self.window?.rootViewController as? UINavigationController)
        detailCoordinator.start()
    }
}
