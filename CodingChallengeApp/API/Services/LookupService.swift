//
//  LookupService.swift
//  CodingApp
//
//  Created by Boni on 10/8/19.
//  Copyright © 2019 Boni. All rights reserved.
//

import Foundation
import Moya

enum LookupService {
    case lookup(parameters: [String: Any])
}

let LookupServiceProvider = MoyaProvider<LookupService>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])

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
        return Data()
    }
    
    var task: Task {
        switch self {
        case .lookup(let parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
}

