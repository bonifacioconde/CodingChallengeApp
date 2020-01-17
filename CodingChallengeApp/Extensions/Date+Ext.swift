//
//  Date+Ext.swift
//  CodingChallengeApp
//
//  Created by Bonz Condz on 17/01/2020.
//  Copyright © 2020 Boni. All rights reserved.
//

import Foundation

extension Date {
    func isWithin(_ distanceTime: TimeInterval, after laterDate: Date) -> Bool {
        let distance = timeIntervalSince(laterDate)
        let result = distanceTime >= distance
        return result
    }
    
    func gmtTimeStamp() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss ZZZZ"
        //formatter.timeZone = TimeZone(abbreviation: "GMT")
        formatter.timeZone = TimeZone(secondsFromGMT:0)
        let defaultTimeZoneStr = formatter.string(from: self)
        return defaultTimeZoneStr
    }
    
    static func getGMTTimestamp() -> String {
        return  Date().gmtTimeStamp()
    }
    
    static func date(from stringDate: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss ZZZZ"
        formatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        let date = formatter.date(from: stringDate)!
        return date
    }
}
