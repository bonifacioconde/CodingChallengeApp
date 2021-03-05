//
//  File.swift
//  CodingChallengeApp
//
//  Created by Bonifacio Conde on 3/4/21.
//  Copyright © 2021 Boni. All rights reserved.
//

import Foundation

class AlbumCellViewModel: AlbumCellViewModelProtocol {
  var album: RMAlbum
  
  init(_ album: RMAlbum) {
    self.album = album
  }
  
  var artworkURLString: String? { album.availableSmallImage() }
  var genre: String? { "Genre: \(album.genre)" }
  var track: String? { "Track: \(album.trackName)" }
  var price: String? { "Price: \(album.priceFormatted() ?? "")" }
}
