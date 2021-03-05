//
//  DetailViewModelResult.swift
//  CodingChallengeApp
//
//  Created by Bonifacio Conde on 3/4/21.
//  Copyright © 2021 Boni. All rights reserved.
//

import Foundation

enum DetailViewModelResult {
  case image(String?)
  case description(String?)
  case price(String?)
  case name(String?)
  case genre(String?)
}

extension DetailViewModelResult: Equatable {
  static func == (
    lhs: DetailViewModelResult,
    rhs: DetailViewModelResult
  ) -> Bool {
    if case .image = lhs, case .image = rhs {
      return true
    } else if case .description = lhs, case  .description = rhs {
      return true
    } else if case  .price = lhs, case  .price = rhs {
      return true
    } else if case  .name = lhs, case  .name = rhs {
      return true
    } else if case  .genre = lhs, case  .genre = rhs {
      return true
    }
    return false
  }
}
