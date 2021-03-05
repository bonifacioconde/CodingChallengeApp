//
//  LookupNetwork.swift
//  CodingChallengeApp
//
//  Created by Bonz Condz on 17/01/2020.
//  Copyright © 2020 Boni. All rights reserved.
//

import Foundation
import Moya

class LookupNetwork: BaseServiceProvider<LookupService>, LookupNetworkableProtocol {
  
  func show(
    with parameters: [String: Any],
    success: @escaping SingleResultWithReturn<ModelResponsbleType, Void>,
    failure: @escaping EmptyResult<Void>
  ) {
    let service = LookupService.lookup(parameters: parameters)
    
    if !(network?.isReachable ?? true) {
      failure()
    }
    
    self.provider.request(service) { (result) in
      self.processResponse(
        result: result,
        success: success,
        failure: nil
      )
    }
  }
}
