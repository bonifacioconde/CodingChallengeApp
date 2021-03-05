//
//  LookupService.swift
//  CodingApp
//
//  Created by Boni on 10/8/19.
//  Copyright © 2019 Boni. All rights reserved.
//

import Foundation
import Moya

let LookupServiceProvider = MoyaProvider<LookupService>(
  plugins: [
    NetworkLoggerPlugin(
      verbose: true,
      responseDataFormatter: JSONResponseDataFormatter
    )
  ]
)

enum LookupService {
    case lookup(parameters: [String: Any])
}


extension LookupService: BaseService {
    var path: String {
        switch self {
        case .lookup:
            return "lookup"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
     var sampleData: Data {
        guard let url = Bundle.main.path(forResource: "detail", ofType: "json") else {
          return Data()
        }
        return try! Data(contentsOf: URL(fileURLWithPath: url))
    }
    
    var task: Task {
        switch self {
        case .lookup(let parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
}
