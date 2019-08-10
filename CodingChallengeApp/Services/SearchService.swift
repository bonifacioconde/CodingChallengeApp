//
//  SearchService.swift
//  CodingApp
//
//  Created by Boni on 10/8/19.
//  Copyright © 2019 Boni. All rights reserved.
//

import Foundation
import SwiftyJSON

enum SearchKey: String, RawEnumProtocol {
    case term = "term"
    case country = "country"
    case media = "media"
    
    public var value: Any? {
        return self.rawValue
    }
}

class SearchService {
    func list(with parameters: [String: Any], complete: @escaping (([JSON], String)->())) {
        let searchKeys = parameters.values.compactMap({ $0 as? String }).joined(separator: "-")
        let service = ItunesAPI.search(parameters: parameters)
        let keyCache = "\(service.path)-\(searchKeys)"
        
        APIRequestCache.shouldGetCache(keyCache) { (isCache, cacheDate, response) in
            if isCache, let json = response {
                complete(json["results"].arrayValue, cacheDate)
            } else {
                ItunesAPIProvider.request(service) { (result) in
                    switch result {
                    case .success(let response):
                        let json = JSON(response.data)
                        APIRequestCache.cacheJSON(json, withKey: keyCache)
                        complete(json["results"].arrayValue, cacheDate)
                    case .failure: break
                    }
                }
            }
        }
    }
}
