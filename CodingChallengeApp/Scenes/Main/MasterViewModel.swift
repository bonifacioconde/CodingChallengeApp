//
//  MasterViewModel.swift
//  CodingApp
//
//  Created by Boni on 10/8/19.
//  Copyright © 2019 Boni. All rights reserved.
//

import Foundation
import Moya

class MasterViewModel: MasterViewModelProtocol {
  var dataSource: AlbumsDataSource
  var resultClosure: SingleResultWithReturn<MasterViewModelResult, Void>!
  var network: NetworkType
  var timeValidity: TimeInterval! = 10// 60 * 1 // 60 seconds
  
  init(
    source: AlbumsDataSource,
    network: NetworkType = SearchNetwork(provider: SearchServiceProvider)) {
    self.dataSource = source
    self.network = network
  }
}

// MARK: Setup

extension MasterViewModel {
  func setupData() {
    let currentTime = Date()
    guard let latestResult: RMAlbumResult = RealmServices.shared.getObjects().last else {
      fetchList()
      return
    }
    
    let isUpToDate = currentTime.isWithin(
        timeValidity,
        after: Date.date(from: latestResult.dateSaved)
    )
    
    if !isUpToDate {
      // print("passed more than a 5 minutess: Update!")
      fetchList()
    } else {
      // print("less than a 5 minutes, do not update")
      update(latestResult)
    }
  }
}

// MARK: Helpers

private extension MasterViewModel {
  func update(_ result: RMAlbumResult) {
    self.dataSource.data = Array(result.results).compactMap { AlbumCellViewModel($0) }
    self.resultClosure?(.done)
    self.resultClosure?(.cacheDate(result.dateSaved))
  }
  
  func fetchList() {
    let parameters = ParameterBuilder()
      .add(value: "star", for: SearchKey.term)
      .add(value: "au", for: SearchKey.country)
      .add(value: "movie", for: SearchKey.media)
      .limit("40")
      .build()
    
    network.list(
      with: parameters,
      complete: handleFetchSuccess(),
      fail: handleFetchError()
    )
  }
}

// MARK: - Event Handlers

private extension MasterViewModel {
  func handleFetchSuccess() ->  SingleResultWithReturn<AlbumResult, Void> {
    return { [weak self] value in
      guard let self = self else { return }
      /// Save result
      let rmAlbumResult = RMAlbumResult()
      rmAlbumResult.dateSaved = Date.getGMTTimestamp()
      let albums = Array(value.results.compactMap({ $0 }) )
      albums.forEach { (album) in
        // Save to realm
        let rmAlbum = RMAlbum.makeRMAlbum(from: album)
        rmAlbumResult.results.append(rmAlbum)
      }
      RealmServices.shared.saveRealm(rmAlbumResult)
      
      self.update(rmAlbumResult)
    }
  }

  func handleFetchError() -> SingleResultWithReturn<[RMAlbum], Void> {
    return { [weak self] error in
      guard let self = self else { return }
    }
  }
}
