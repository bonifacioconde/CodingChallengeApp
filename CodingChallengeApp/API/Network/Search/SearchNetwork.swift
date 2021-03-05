//
//  SearchNetwork.swift
//  CodingChallengeApp
//
//  Created by Bonz Condz on 17/01/2020.
//  Copyright © 2020 Boni. All rights reserved.
//

import Foundation
import Moya

class SearchNetwork: BaseServiceProvider<SearchService>, SearchNetworkableProtocol {
  func list(
    with parameters: [String: Any],
    complete: @escaping SingleResultWithReturn<AlbumResult, Void>,
    fail: @escaping SingleResultWithReturn<[RMAlbum], Void>
  ) {
    let service = SearchService.search(parameters: parameters)
    
    self.provider.request(service) { (result) in
      self.processResponse(
        result: result,
        success: complete,
        failure: nil)
    }
    
  }
}
