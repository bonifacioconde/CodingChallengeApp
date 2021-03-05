//
//  File.swift
//  CodingChallengeApp
//
//  Created by Bonifacio Conde on 3/4/21.
//  Copyright © 2021 Boni. All rights reserved.
//

import Foundation

protocol LookupNetworkableProtocol: ModelResponsbleProtocol where ModelResponsbleType == AlbumResult {
  func show(
    with parameters: [String: Any],
    success: @escaping SingleResultWithReturn<ModelResponsbleType, Void>,
    failure: @escaping EmptyResult<Void>
  )
}
