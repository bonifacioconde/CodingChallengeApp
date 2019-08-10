//
//  APICacheRequest.swift
//  CodingApp
//
//  Created by Boni on 10/8/19.
//  Copyright © 2019 Boni. All rights reserved.
//

import Foundation
import SwiftyJSON

public class APIRequestCache {
    static let time: Int = 60 // n minutes
    static let stringDateFormatter: String = "EEEE, MMM d, yyyy - h:mm a"
    
    public class func shouldGetCache(_ key: String, _ noCache: Bool = false, complete: @escaping ((_ isSuccess: Bool, _ cacheDate: String, _ json: JSON?) -> ())) {
        let cache = JSONFileCache(name: "\(key)")
        let currentCacheTime = Date()
        let cacheTime = cache.getfileCreatedDate()
        let elapsedTime = (Int(currentCacheTime.timeIntervalSince(cacheTime)) % 3600) / 60
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = stringDateFormatter
        if  !noCache, elapsedTime < time || !(network?.isReachable ?? true), let data = cache.read() {
            let json = JSON(data: data)
            complete(true, dateFormatter.string(from: cacheTime), json)
        } else {
            cache.clear()
            complete(false, dateFormatter.string(from: currentCacheTime), nil)
        }
        
    }
    
    public class func cacheJSON(_ json: JSON, withKey key: String) {
        JSONFileCache(name: "\(key)").write(json: json)
    }
}

