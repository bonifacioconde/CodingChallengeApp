//
//  MasterViewModel.swift
//  CodingApp
//
//  Created by Boni on 10/8/19.
//  Copyright © 2019 Boni. All rights reserved.
//

import Foundation
import Moya

protocol MasterViewCoordinatorDelegate: class {
  func masterShowDetail(from album: RMAlbum?)
}

protocol ViewModelNetworkableProtocol {
  associatedtype T
  var network: T { get set }
}

class MasterViewModel: ViewModelNetworkableProtocol {
  typealias T = SearchNetwork
  var network: T
  
  
  /// ViewModelNetworkableProtocol
  
  /// Types of result MasterViewModel will give
  enum MasterViewModelResult {
    case cacheDate(String)
    case done
  }
  
  var dataSource: AlbumsDataSource
  var timeValidity: TimeInterval = 10//60 * 1 // 60 seconds
  
  weak var coordinatorDelegate: MasterViewCoordinatorDelegate?
  var resultClosure: ((MasterViewModelResult) -> Void)?
  
  init(source: AlbumsDataSource, network: T) {
    self.dataSource = source
    self.network = network
  }
  
  func setupData() {
    let currentTime = Date()
    guard let latestResult: RMAlbumResult = RealmServices.shared.getObjects().last else {
      fetchList()
      return
    }
    
    let isUpToDate = currentTime.isWithin(timeValidity, after: Date.date(from: latestResult.dateSaved))
    
    if !isUpToDate {
      //print("passed more than a 5 minutess: Update!")
      fetchList()
    } else {
      //print("less than a 5 minutes, do not update")
      self.dataSource.data = Array(latestResult.results)
      self.resultClosure?(.done)
      self.resultClosure?(.cacheDate(latestResult.dateSaved))
    }
  }
  
  private func fetchList() {
    let parameters = ParameterBuilder()
      .add(value: "star", for: SearchKey.term)
      .add(value: "au", for: SearchKey.country)
      .add(value: "movie", for: SearchKey.media)
      .limit("40")
      .build()
    
    network.list(with: parameters, complete: { (value) in
      
      /// Save result
      let rmAlbumResult = RMAlbumResult()
      rmAlbumResult.dateSaved = Date.getGMTTimestamp()
      let albums = Array(value.results.compactMap({ $0 }) )
      albums.forEach { (album) in
        //Save to realm
        let rmAlbum = RMAlbum.makeRMAlbum(from: album)
        rmAlbumResult.results.append(rmAlbum)
      }
      RealmServices.shared.saveRealm(rmAlbumResult)
      
      self.dataSource.data = Array(rmAlbumResult.results)
      self.resultClosure?(.done)
      self.resultClosure?(.cacheDate(rmAlbumResult.dateSaved))
    }, fail: { _ in
      
    })
  }
}
