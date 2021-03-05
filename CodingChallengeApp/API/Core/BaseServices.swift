//
//  BaseServices.swift
//  CodingChallengeApp
//
//  Created by Bonz Condz on 17/01/2020.
//  Copyright © 2020 Boni. All rights reserved.
//

import Foundation
import Moya
import Alamofire

let network = NetworkReachabilityManager()

/// BaseService conforms to Moya TargetType protocol
protocol BaseService: TargetType {
}


extension BaseService {
  
  /**
   The headers needed for the request
   */
  var headers: [String: String]? {
    return nil
  }
  
  
  /**
   The baseURL needed for the request
   */
  var baseURL: URL {
    var baseURL: URL { return URL(string: "https://itunes.apple.com")! }
    return baseURL
  }
}


func JSONResponseDataFormatter(_ data: Data) -> Data {
  do {
    let dataAsJSON = try JSONSerialization.jsonObject(with: data)
    let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
    return prettyData
  } catch {
    return data // fallback to original data if it can't be serialized.
  }
}
