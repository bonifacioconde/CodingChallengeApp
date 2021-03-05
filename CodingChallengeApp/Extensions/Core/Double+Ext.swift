//
//  Double+Ext.swift
//  CodingApp
//
//  Created by Boni on 10/8/19.
//  Copyright © 2019 Boni. All rights reserved.
//

import Foundation

extension Double {
    func priceFormatter(with currencyCode: String) -> String? {
        let formatter = NumberFormatter()
        formatter.currencyCode = currencyCode
        formatter.numberStyle = .currency
        formatter.currencySymbol = currencyCode
        return formatter.string(from: NSNumber(value: self))
    }
}
