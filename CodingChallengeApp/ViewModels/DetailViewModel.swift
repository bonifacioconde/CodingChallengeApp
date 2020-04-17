//
//  DetailViewModel.swift
//  CodingApp
//
//  Created by Boni on 10/8/19.
//  Copyright © 2019 Boni. All rights reserved.
//

import UIKit
import Moya

class DetailViewModel {
  
  /// Types of result DetailViewModel will give
  enum DetailViewModelResult {
    case image(String?)
    case description(String?)
    case price(String?)
    case name(String?)
    case genre(String?)
  }
  
  
  var album: RMAlbum
  lazy var lookupNetwork: LookupNetwork = {
    let serviceProvider = LookupServiceProvider
    let network: LookupNetwork = LookupNetwork(provider: serviceProvider)
    return network
  }()
  
  var detailResultClosure: ((DetailViewModelResult) -> Void)?
  
  init(album: RMAlbum) {
    self.album = album
  }
  
  func setupDisplay() {
    func setupResult(from val: RMAlbum) {
      detailResultClosure?(.image(album.availableLargeImage()))
      detailResultClosure?(.description(album.desc))
      detailResultClosure?(.price(album.priceFormatted()))
      detailResultClosure?(.name(album.trackName))
      detailResultClosure?(.genre(album.genre))
    }
    
    guard let trackId = album.trackId.value else {
      setupResult(from: album)
      return
    }
    
    let parameter = ParameterBuilder().add(value: "\(trackId)", for: LookupKey.id).build()
    lookupNetwork.show(with: parameter, success: { (values) in
      if let lookUpAlbum = Array(
        values.results.compactMap({ $0 })
      ).first {
        
        //Save to realm
        let rmAlbum = RMAlbum.makeRMAlbum(from: lookUpAlbum)
        RealmServices.shared.saveRealm(rmAlbum)
        
        setupResult(from: rmAlbum)
      } else {
        setupResult(from: self.album)
      }
    }, failure: {
      setupResult(from: self.album)
    })
  }
}
