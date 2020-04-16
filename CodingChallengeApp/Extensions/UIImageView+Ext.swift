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
    func processLink(_ string: String?,
                     with placeHolder: UIImage? = nil,
                     failure: (() -> Void)? = nil) {
        if let unwrappedString = string,
          let url = URL(string: unwrappedString),
          UIApplication.shared.canOpenURL(url),
          !unwrappedString.contains("default") {
            self.kf.setImage(with: url,
                             placeholder: placeHolder,
                             options: [.transition(.fade(0.25))],
                             progressBlock: nil, completionHandler: nil)
        } else {
            self.image = placeHolder
            failure?()
        }
    }
}
