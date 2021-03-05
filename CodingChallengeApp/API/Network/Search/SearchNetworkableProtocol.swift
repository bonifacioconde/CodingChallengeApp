//
//  File.swift
//  CodingChallengeApp
//
//  Created by Bonifacio Conde on 3/4/21.
//  Copyright © 2021 Boni. All rights reserved.
//

import Foundation

protocol SearchNetworkableProtocol: ModelResponsbleProtocol where ModelResponsbleType == Album {
  func list(
    with parameters: [String: Any],
    complete: @escaping SingleResultWithReturn<AlbumResult, Void>,
    fail: @escaping SingleResultWithReturn<[RMAlbum], Void>
  )
}
