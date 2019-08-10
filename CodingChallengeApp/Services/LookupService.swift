//
//  LookupService.swift
//  CodingApp
//
//  Created by Boni on 10/8/19.
//  Copyright © 2019 Boni. All rights reserved.
//

import Foundation
import SwiftyJSON

enum LookupKey: String, RawEnumProtocol {
    case id = "id"
    case amgArtistId = "amgArtistId"
    case entity = "entity"
    case sort = "sort"
    case upc = "upc"
    case amgAlbumId = "amgAlbumId"
    case isbn = "isbn"
    
    public var value: Any? {
        return self.rawValue
    }
}

class LookupService {
    typealias LookupSuccess = (([JSON], String)->())
    
    func show(with parameters: [String: Any], success: @escaping LookupSuccess, failure: @escaping (()->())) {
        let lookupKeys = parameters.values.compactMap({ $0 as? String }).joined(separator: "-")
        let service = ItunesAPI.lookup(parameters: parameters)
        let keyCache = "\(service.path)-\(lookupKeys)"
        
        if !(network?.isReachable ?? true) {
            failure()
        }
        
        APIRequestCache.shouldGetCache(keyCache) { (isCache, cacheDate, response) in
            if isCache, let json = response {
                success(json["results"].arrayValue, cacheDate)
            } else {
                ItunesAPIProvider.request(service) { (result) in
                    switch result {
                    case .success(let response):
                        let json = JSON(response.data)
                        APIRequestCache.cacheJSON(json, withKey: keyCache)
                        success(json["results"].arrayValue, cacheDate)
                    case .failure:
                        failure()
                    }
                }
            }
        }
    }
}

