//
//  DetailCoordinator.swift
//  CodingApp
//
//  Created by Boni on 10/8/19.
//  Copyright © 2019 Boni. All rights reserved.
//

import UIKit

class DetailCoordinator: Coordinator {
    var navigationController: UINavigationController?
    var album: Album
    
    init(album: Album, navigationController: UINavigationController?) {
        self.album = album
        self.navigationController = navigationController
    }
    
    func start() {
        let detailViewModel = DetailViewModel(album: self.album)
        let vc = DetailViewController.instantiate(fromAppStoryboard: .main)
        vc.viewModel = detailViewModel
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
