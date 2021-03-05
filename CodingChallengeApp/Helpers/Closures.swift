//
//  Closures.swift
//  CodingChallengeApp
//
//  Created by Bonifacio Conde on 3/4/21.
//  Copyright © 2021 Boni. All rights reserved.
//

import Foundation

// MARK: - Typealiases

// Empty Result + Void Return
typealias EmptyResult<ReturnType> = () -> ReturnType

// Custom Result + Custom Return
typealias SingleResultWithReturn<T, ReturnType> = ((T) -> ReturnType)

// Custom Result + Void Return
typealias SingleResult<T> = SingleResultWithReturn<T, Void>

// Common
typealias VoidResult = EmptyResult<Void> // () -> Void
