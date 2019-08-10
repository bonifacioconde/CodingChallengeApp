//
//  Album.swift
//  CodingApp
//
//  Created by Boni on 10/8/19.
//  Copyright © 2019 Boni. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Album {
    
    var trackName: String?
    var artworkLarge: String?
    var artworkMedium: String?
    var artworkSmall: String?
    var price: Double
    var genre: String?
    var description: String?
    var currency: String?
    var trackId: Int?
    
    init?(json: JSON) {
        guard let data = json.dictionary else { return nil }
        trackName = data["trackName"]?.string
        artworkLarge = data["artworkUrl100"]?.string
        artworkMedium = data["artworkUrl60"]?.string
        artworkSmall = data["artworkUrl30"]?.string
        price = data["collectionPrice"]?.doubleValue ?? 0.0
        genre = data["primaryGenreName"]?.string
        description = data["longDescription"]?.string
        currency = data["currency"]?.string
        trackId = data["trackId"]?.intValue
    }
}

extension Album {
    func priceFormatted() -> String? {
        return price.priceFormatter(with: currency ?? "USD")
    }
    
    func availableSmallImage() -> String? {
        if !(artworkSmall?.isEmpty ?? true) {
            return artworkSmall
        } else if !(artworkMedium?.isEmpty ?? true) {
            return artworkMedium
        } else if !(artworkLarge?.isEmpty ?? true) {
            return artworkLarge
        }
        return nil
    }
    
    func availableLargeImage() -> String? {
        if !(artworkLarge?.isEmpty ?? true) {
            return artworkLarge
        } else if !(artworkMedium?.isEmpty ?? true) {
            return artworkMedium
        } else if !(artworkSmall?.isEmpty ?? true) {
            return artworkSmall
        }
        return nil
    }
}
