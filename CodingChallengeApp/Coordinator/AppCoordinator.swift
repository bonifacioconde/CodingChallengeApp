//
//  AppCoordinator.swift
//  CodingApp
//
//  Created by Boni on 10/8/19.
//  Copyright © 2019 Boni. All rights reserved.
//

import UIKit
import Alamofire

let network = NetworkReachabilityManager()
class AppCoordinator: Coordinator {
    var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        let masterCoordinator = MasterCoordinator(window: self.window)
        masterCoordinator.start()
    }
}
