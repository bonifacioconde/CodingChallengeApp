//
//  LookupNetwork.swift
//  CodingChallengeApp
//
//  Created by Bonz Condz on 17/01/2020.
//  Copyright © 2020 Boni. All rights reserved.
//

import Foundation
import Moya

typealias LookupSuccess = ((AlbumResult) -> Void)

protocol LookupNetworkableProtocol: ModelResponsbleProtocol {
    func show(with parameters: [String: Any], success: @escaping LookupSuccess, failure: @escaping (() -> Void))
}

class LookupProviderableProtocol<T: TargetType>: NSObject {
  var provider: MoyaProvider<T>
  
  init(provider: MoyaProvider<T>) {
    self.provider = provider
  }
}

class LookupNetwork: LookupProviderableProtocol<LookupService>, LookupNetworkableProtocol {
  typealias T = AlbumResult
  
    func show(with parameters: [String: Any], success: @escaping LookupSuccess, failure: @escaping (() -> Void)) {
        let service = LookupService.lookup(parameters: parameters)
        
        if !(network?.isReachable ?? true) {
            failure()
        }
        
      self.provider.request(service) { (result) in
            self.processResponse(result: result, success: success, failure: nil)
        }
    }
}
