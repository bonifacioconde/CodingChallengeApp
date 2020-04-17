//
//  SearchNetwork.swift
//  CodingChallengeApp
//
//  Created by Bonz Condz on 17/01/2020.
//  Copyright © 2020 Boni. All rights reserved.
//

import Foundation
import Moya

protocol SearchNetworkableProtocol: ModelResponsbleProtocol {
  func list(with parameters: [String: Any],
            complete: @escaping ((AlbumResult) -> Void),
            fail: @escaping (([RMAlbum]) -> Void))
}

class ServiceProviderableProtocol<T: TargetType>: NSObject {
  var provider: MoyaProvider<T>
  
  init(provider: MoyaProvider<T>) {
    self.provider = provider
  }
}

class SearchNetwork: ServiceProviderableProtocol<SearchService>, SearchNetworkableProtocol {
  typealias T = Album
  
  
  func list(with parameters: [String: Any],
            complete: @escaping ((AlbumResult) -> Void),
            fail: @escaping (([RMAlbum]) -> Void)) {
    let service = SearchService.search(parameters: parameters)
    
    
    self.provider.request(service) { (result) in
      self.processResponse(result: result, success: complete, failure: nil)
    }
    
  }
}
