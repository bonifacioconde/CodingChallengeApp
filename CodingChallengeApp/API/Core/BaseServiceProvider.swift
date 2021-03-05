//
//  BaseServiceProvider.swift
//  CodingChallengeApp
//
//  Created by Bonifacio Conde on 3/4/21.
//  Copyright © 2021 Boni. All rights reserved.
//

import Foundation
import Moya

class BaseServiceProvider<T: TargetType>: NSObject {
  var provider: MoyaProvider<T>
  
  init(provider: MoyaProvider<T>) {
    self.provider = provider
  }
}
