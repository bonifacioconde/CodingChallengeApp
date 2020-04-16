//
//  SearchService.swift
//  CodingApp
//
//  Created by Boni on 10/8/19.
//  Copyright © 2019 Boni. All rights reserved.
//

import Foundation
import Moya

enum SearchService {
    case search(parameters: [String: Any])
}

let SearchServiceProvider = MoyaProvider<SearchService>(
  plugins: [
    NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)
  ]
)


enum SearchKey: String, RawEnumProtocol {
    case term
    case country
    case media
    
    public var value: Any? {
        return self.rawValue
    }
}

extension SearchService: BaseService {
    var path: String {
        switch self {
        case .search:
            return "search"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        guard let url = Bundle.main.path(forResource: "search", ofType: "json") else {
          return Data()
        }
        return try! Data(contentsOf: URL(fileURLWithPath: url))
    }
    
    var task: Task {
        switch self {
        case .search(let parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
}
