//
//  ViewModelNetworkableProtocol.swift
//  CodingChallengeApp
//
//  Created by Bonifacio Conde on 3/4/21.
//  Copyright © 2021 Boni. All rights reserved.
//

import Foundation

protocol ViewModelNetworkableProtocol {
  associatedtype NetworkableType
  var network: NetworkableType { get set }
}
