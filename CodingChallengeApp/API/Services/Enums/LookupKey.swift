//
//  LookupKey.swift
//  CodingChallengeApp
//
//  Created by Bonifacio Conde on 3/4/21.
//  Copyright © 2021 Boni. All rights reserved.
//

import Foundation

enum LookupKey: String, RawEnumProtocol {
    case id
    case amgArtistId
    case entity
    case sort
    case upc
    case amgAlbumId
    case isbn
    
    public var value: Any? {
        return self.rawValue
    }
}
