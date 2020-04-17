//
//  Album.swift
//  CodingApp
//
//  Created by Boni on 10/8/19.
//  Copyright © 2019 Boni. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class AlbumResult: Codable {
    enum CodingKeys: String, CodingKey {
        case results
    }

    public var results: [Album]
    
}

@objcMembers class RMAlbumResult: Object {
    dynamic var dateSaved = ""
    let results = RealmSwift.List<RMAlbum>()

    override static func primaryKey() -> String? {
        return "dateSaved"
    }
}

class Album: Codable {
    enum CodingKeys: String, CodingKey {
        case trackName
        case artworkLarge = "artworkUrl100"
        case artworkMedium = "artworkUrl60"
        case artworkSmall = "artworkUrl30"
        case price = "collectionPrice"
        case genre = "primaryGenreName"
        case desc = "longDescription"
        case currency
        case trackId
    }
    
    public var trackName: String?
    public var artworkLarge: String?
    public var artworkMedium: String?
    public var artworkSmall: String?
    public var price: Double? = 0
    public var genre: String?
    public var desc: String?
    public var currency: String?
    public var trackId: Int?
}


@objcMembers class RMAlbum: Object {
    dynamic var trackName = ""
    dynamic var artworkLarge = ""
    dynamic var artworkMedium = ""
    dynamic var artworkSmall = ""
    dynamic var price = RealmOptional<Double>()
    dynamic var genre = ""
    dynamic var desc = ""
    dynamic var currency = ""
    dynamic var trackId = RealmOptional<Int>()

    override static func primaryKey() -> String? {
        return "trackName"
    }

}

extension RMAlbum {
    func priceFormatted() -> String? {
        return price.value?.priceFormatter(with: currency)
    }

    func availableSmallImage() -> String? {
        if !(artworkSmall.isEmpty ) {
            return artworkSmall
        } else if !(artworkMedium.isEmpty) {
            return artworkMedium
        } else if !(artworkLarge.isEmpty) {
            return artworkLarge
        }
        return nil
    }

    func availableLargeImage() -> String? {
        if !(artworkLarge.isEmpty) {
            return artworkLarge
        } else if !(artworkMedium.isEmpty) {
            return artworkMedium
        } else if !(artworkSmall.isEmpty) {
            return artworkSmall
        }
        return nil
    }
  
  static func makeRMAlbum(from album: Album) -> RMAlbum {
    let rmAlbum: RMAlbum = RMAlbum()
    rmAlbum.trackName = album.trackName ?? ""
    rmAlbum.artworkLarge = album.artworkLarge ?? ""
    rmAlbum.artworkMedium = album.artworkMedium ?? ""
    rmAlbum.artworkSmall = album.artworkSmall ?? ""
    rmAlbum.price.value = album.price
    rmAlbum.genre = album.genre ?? ""
    rmAlbum.desc = album.desc ?? ""
    rmAlbum.currency = album.currency ?? ""
    rmAlbum.trackId.value = album.trackId
    return rmAlbum
  }
}

extension AlbumResult: Equatable {
  static func == (lhs: AlbumResult, rhs: AlbumResult) -> Bool {
    return lhs.results == rhs.results
  }
}

extension Album: Equatable {
  static func == (lhs: Album, rhs: Album) -> Bool {
    return lhs.trackId == rhs.trackId
  }
}
