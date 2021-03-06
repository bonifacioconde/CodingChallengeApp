//
//  ParameterBuilder.swift
//  CodingApp
//
//  Created by Boni on 10/8/19.
//  Copyright © 2019 Boni. All rights reserved.
//

import Foundation

public protocol RawEnumProtocol {
  var value: Any? { get }
}

public class ParameterBuilder {
  private var param = [String: Any]()
  
  public init() {}
  
  public func add(value: Any, for key: RawEnumProtocol) -> ParameterBuilder {
    if key.value is String {
      guard let kv = key.value as? String else {
        return self
      }
      self.param.updateValue(value, forKey: kv)
    }
    
    return self
  }
  
  public func limit( _ value: Int) -> ParameterBuilder {
    self.param.updateValue(value, forKey: "limit")
    return self
  }
  
  public func limit( _ value: String) -> ParameterBuilder {
    self.param.updateValue(value, forKey: "limit")
    return self
  }
  
  public func build() -> [String: Any] {
    
    return self.param
  }
}
