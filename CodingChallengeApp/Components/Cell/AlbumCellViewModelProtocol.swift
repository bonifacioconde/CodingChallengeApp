//
//  AlbumCellViewModelProtocol.swift
//  CodingChallengeApp
//
//  Created by Bonifacio Conde on 3/4/21.
//  Copyright © 2021 Boni. All rights reserved.
//

import Foundation

protocol AlbumCellViewModelProtocol {
  var album: RMAlbum { get set }
  var artworkURLString: String? { get }
  var genre: String? { get }
  var track: String? { get }
  var price: String? { get }
}
