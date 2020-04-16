//
//  SearchNetwork.swift
//  CodingChallengeApp
//
//  Created by Bonz Condz on 17/01/2020.
//  Copyright © 2020 Boni. All rights reserved.
//

import Foundation

protocol SearchNetworkableProtocol: class {
  func list(with parameters: [String: Any],
            complete: @escaping ((AlbumResult) -> Void),
            fail: @escaping (([RMAlbum]) -> Void))
}

class SearchNetwork: BaseNetwork, SearchNetworkableProtocol {
    func list(with parameters: [String: Any],
              complete: @escaping ((AlbumResult) -> Void),
              fail: @escaping (([RMAlbum]) -> Void)) {
        let service = SearchService.search(parameters: parameters)
        

        SearchServiceProvider.request(service) { (result) in
            self.processResponse(result: result, success: complete, failure: nil)
        }
        
    }
}
