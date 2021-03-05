//
//  SearchKey.swift
//  CodingChallengeApp
//
//  Created by Bonifacio Conde on 3/4/21.
//  Copyright © 2021 Boni. All rights reserved.
//

import Foundation

enum SearchKey: String, RawEnumProtocol {
    case term
    case country
    case media
    
    public var value: Any? {
        return self.rawValue
    }
}
