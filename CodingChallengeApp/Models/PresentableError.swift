//
//  PresentableError.swift
//  CodingChallengeApp
//
//  Created by Bonz Condz on 17/01/2020.
//  Copyright © 2020 Boni. All rights reserved.
//

import Foundation

/// Errors to be presented properly
public class PresentableError: Error {
    private(set) public var title: String
    private(set) public var message: String
    private(set) public var code: Int?

  convenience public init() {
    let message = """
    Oops! Something went wrong!\n
    Help us improve your experience by sending an error report.
    """
    self.init(title: "Error!", message: message)
  }

    convenience public init(message: String, code: Int? = nil) {
        self.init(title: "Error!", message: message, code: code)
    }

    public init(title: String, message: String, code: Int? = nil) {
        self.message = message
        self.title = title
        self.code = code
    }
}
