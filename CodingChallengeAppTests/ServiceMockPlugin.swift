//
//  ServiceMockPlugin.swift
//  CodingChallengeAppTests
//
//  Created by Bonz Condz on 16/04/2020.
//  Copyright © 2020 Boni. All rights reserved.
//

@testable
import CodingChallengeApp
import Moya

class ServiceMockPlugin: PluginType {
  func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
    switch target {
    case is SearchService:
      guard
        let apiTarget = target as? SearchService,
        case .search = apiTarget else {
          return
      }
    case is LookupService:
      guard
        let apiTarget = target as? LookupService,
        case .lookup = apiTarget else {
          return
      }
    default:
      return
    }
  }
  
  func customEndpointClosure(_ target: TargetType) -> Endpoint {
    var url: String = ""
    var responseClosure: Endpoint.SampleResponseClosure = { .networkResponse(502, target.sampleData) }
    var method: Moya.Method = .get
    var task: Task = .requestPlain
    var headerFields: [String: String]? = .none

    switch target {
    case is SearchService:
      if let apiTarget = target as? SearchService {
        url = URL(target: apiTarget).absoluteString
        responseClosure = { .networkResponse(200, apiTarget.sampleData) }
        method = apiTarget.method
        task = apiTarget.task
        headerFields = apiTarget.headers
      }
    case is LookupService:
      if let apiTarget = target as? LookupService {
        url = URL(target: apiTarget).absoluteString
        responseClosure = { .networkResponse(200, apiTarget.sampleData) }
        method = apiTarget.method
        task = apiTarget.task
        headerFields = apiTarget.headers
      }
      
    default: break
    }
    return useEndpoint(with: url,
                       responseClosure: responseClosure,
                       method: method,
                       task: task,
                       headerFields: headerFields)
    
  }
  
  private func useEndpoint(with urlString: String,
                   responseClosure: @escaping Endpoint.SampleResponseClosure,
                   method: Moya.Method,
                   task: Task,
                   headerFields: [String: String]?) -> Endpoint {
    
    return Endpoint(url: urlString,
                    sampleResponseClosure: responseClosure,
                    method: method,
                    task: task,
                    httpHeaderFields: headerFields)
  }

}
