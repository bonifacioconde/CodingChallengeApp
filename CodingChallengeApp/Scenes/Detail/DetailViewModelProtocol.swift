//
//  File.swift
//  CodingChallengeApp
//
//  Created by Bonifacio Conde on 3/4/21.
//  Copyright © 2021 Boni. All rights reserved.
//

import Foundation

protocol DetailViewModelProtocol: ViewModelNetworkableProtocol {
  typealias NetworkType = LookupNetwork
  var network: NetworkType { get }
  var albumCellVM: AlbumCellViewModelProtocol { get }
  var resultClosure: SingleResultWithReturn<DetailViewModelResult, Void>! { get }
}
