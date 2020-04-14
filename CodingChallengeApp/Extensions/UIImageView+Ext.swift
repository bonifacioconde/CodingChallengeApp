//
//  UIImageView+Ext.swift
//  CodingApp
//
//  Created by Boni on 10/8/19.
//  Copyright © 2019 Boni. All rights reserved.
//

import UIKit
import Kingfisher

public extension UIImageView {
    func processLink(_ string: String?, with placeHolder: UIImage? = nil) {
        if let string = string,
          let url = URL(string: string),
          UIApplication.shared.canOpenURL(url),
          !string.contains("default") {
            self.kf.setImage(with: url,
                             placeholder: placeHolder,
                             options: [.transition(.fade(0.25))],
                             progressBlock: nil, completionHandler: nil)
        } else {
            self.image = placeHolder
        }
    }
    
    func processLink(_ string: String?,
                     with placeHolder: UIImage? = nil,
                     failure: @escaping (() -> Void)) {
        if let string = string,
          let url = URL(string: string),
          UIApplication.shared.canOpenURL(url),
          !string.contains("default") {
            self.kf.setImage(with: url,
                             placeholder: placeHolder,
                             options: [.transition(.fade(0.25))],
                             progressBlock: nil, completionHandler: nil)
        } else {
            self.image = placeHolder
            failure()
        }
    }
}
