//
//  File.swift
//  CodingChallengeApp
//
//  Created by Bonifacio Conde on 3/4/21.
//  Copyright © 2021 Boni. All rights reserved.
//

import Foundation

protocol MasterViewModelProtocol: ViewModelNetworkableProtocol {
  typealias NetworkType = SearchNetwork
  var network: NetworkType { get }
  var dataSource: AlbumsDataSource { get }
  var resultClosure: SingleResultWithReturn<MasterViewModelResult, Void>! { get }
  var timeValidity: TimeInterval! { get }
  
  func setupData()
}
