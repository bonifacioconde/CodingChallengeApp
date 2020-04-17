//
//  BaseDataSource.swift
//  CodingChallengeApp
//
//  Created by Bonz Condz on 17/01/2020.
//  Copyright © 2020 Boni. All rights reserved.
//

import Foundation

class GenericDataSource<T>: NSObject {
    var data: [T] = []
}
