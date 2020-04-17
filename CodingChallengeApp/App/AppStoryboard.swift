//
//  AppStoryboard.swift
//  CodingApp
//
//  Created by Boni on 10/8/19.
//  Copyright © 2019 Boni. All rights reserved.
//

import Foundation
import UIKit

enum AppStoryboard: String {
  
  case main = "Main"
  
  var instance: UIStoryboard {
    return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
  }
  
  func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T? {
    let storyBoardID = (viewControllerClass as UIViewController.Type).storyboardID
    let scene = instance.instantiateViewController(withIdentifier: storyBoardID) as? T
    return scene
  }
  
}

extension UIViewController {
  
  static var storyboardID: String {
    return "\(self)"
  }
  
  static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
    return appStoryboard.viewController(viewControllerClass: self)!
  }
}
