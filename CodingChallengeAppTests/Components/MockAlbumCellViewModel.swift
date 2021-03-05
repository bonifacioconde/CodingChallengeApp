//
//  File.swift
//  CodingChallengeAppTests
//
//  Created by Bonifacio Conde on 3/5/21.
//  Copyright © 2021 Boni. All rights reserved.
//

import Quick
import Nimble
@testable
import CodingChallengeApp


class MockAlbumCellViewModel: AlbumCellViewModelProtocol {
  var album: RMAlbum = RMAlbum.makeRMAlbum(from: Album())
  var artworkURLString: String? = "Mock url"
  var genre: String? = "Mock genre"
  var track: String? = "Mock track"
  var price: String? = "Mock price"
}
