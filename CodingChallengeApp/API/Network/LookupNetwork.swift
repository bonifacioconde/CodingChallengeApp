//
//  LookupNetwork.swift
//  CodingChallengeApp
//
//  Created by Bonz Condz on 17/01/2020.
//  Copyright © 2020 Boni. All rights reserved.
//

import Foundation

typealias LookupSuccess = ((AlbumResult)->())

class LookupNetwork: BaseNetwork {
    func show(with parameters: [String: Any], success: @escaping LookupSuccess, failure: @escaping (()->())) {
        let service = LookupService.lookup(parameters: parameters)
        
        if !(network?.isReachable ?? true) {
            failure()
        }
        
        LookupServiceProvider.request(service) { (result) in
            self.processResponse(result: result, success: success, failure: nil)
        }
    }
}


