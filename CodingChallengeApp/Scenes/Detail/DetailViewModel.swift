//
//  DetailViewModel.swift
//  CodingApp
//
//  Created by Boni on 10/8/19.
//  Copyright © 2019 Boni. All rights reserved.
//

import UIKit
import Moya

class DetailViewModel: DetailViewModelProtocol {
  var albumCellVM: AlbumCellViewModelProtocol
  var network: NetworkType
  var resultClosure: SingleResultWithReturn<DetailViewModelResult, Void>!
  
  init(
    albumCellVM: AlbumCellViewModelProtocol,
    network: NetworkType = LookupNetwork(provider: LookupServiceProvider)) {
    self.albumCellVM = albumCellVM
    self.network = network
  }
}

// MARK: Setup

extension DetailViewModel {
  func setupDisplay() {
    guard let trackId = albumCellVM.album.trackId.value else {
      let album = albumCellVM.album
      setupResult(from: album)
      return
    }
    
    let parameter = ParameterBuilder()
      .add(value: "\(trackId)", for: LookupKey.id)
      .build()
    
    network.show(
      with: parameter,
      success: handleShowSuccess(),
      failure: handleFetchError()
    )
  }
}

// MARK: Helpers

private extension DetailViewModel {
  func setupResult(from val: RMAlbum) {
    resultClosure?(.image(val.availableLargeImage()))
    resultClosure?(.description("Description:\n\(val.desc )"))
    resultClosure?(.price("Price: \(val.priceFormatted() ?? "")"))
    resultClosure?(.name("Track: \(val.trackName )"))
    resultClosure?(.genre("Genre: \(val.genre )"))
  }
}

// MARK: - Event Handlers

private extension DetailViewModel {
  func handleShowSuccess() ->  SingleResultWithReturn<AlbumResult, Void> {
    return { [weak self] value in
      guard let self = self else { return }
      if let lookUpAlbum = Array(
        value.results.compactMap({ $0 })
      ).first {
        
        // Save to realm
        let rmAlbum = RMAlbum.makeRMAlbum(from: lookUpAlbum)
        RealmServices.shared.saveRealm(rmAlbum)
        self.setupResult(from: rmAlbum)
      } else {
        self.setupResult(from: self.albumCellVM.album)
      }
    }
  }
  
  func handleFetchError() -> EmptyResult<Void> {
    return { [weak self] in
      guard let self = self else { return }
    }
  }
}
