//
//  MasterViewModel.swift
//  CodingApp
//
//  Created by Boni on 10/8/19.
//  Copyright © 2019 Boni. All rights reserved.
//

import Foundation

enum MasterViewModelResult {
    case cacheDate(String)
    case done
}

protocol MasterViewCoordinatorDelegate: class {
    func masterShowDetail(from album: RMAlbum?)
}


class MasterViewModel {
    var dataSource: AlbumsDataSource
    var timeValidity: TimeInterval = 10//60 * 1 // 60 seconds
    
    let searchNetwork: SearchNetwork = SearchNetwork()
    
    weak var coordinatorDelegate: MasterViewCoordinatorDelegate?
    var resultClosure: ((MasterViewModelResult) -> Void)?
    
    init(source: AlbumsDataSource) {
        self.dataSource = source
    }
    
    func loadData() {
        let currentTime = Date()
        guard let latestResult: RMAlbumResult = RealmServices.shared.getObjects().last else {
            requestList()
            return
        }
        
        let isUpToDate = currentTime.isWithin(timeValidity, after: Date.date(from: latestResult.dateSaved))
        
        if !isUpToDate {
            //print("passed more than a 5 minutess: Update!")
            requestList()
        } else {
            //print("less than a 5 minutes, do not update")
            self.dataSource.data = Array(latestResult.results)
            self.resultClosure?(.done)
            self.resultClosure?(.cacheDate(latestResult.dateSaved))
        }
        
        
    }
    
    private func requestList() {
        let parameters = ParameterBuilder()
            .add(value: "star", for: SearchKey.term)
            .add(value: "au", for: SearchKey.country)
            .add(value: "movie", for: SearchKey.media)
            .limit("40")
            .build()
        
        searchNetwork.list(with: parameters, complete: { (value) in
            
            /// Save result
            let rmAlbumResult = RMAlbumResult()
            rmAlbumResult.dateSaved = Date.getGMTTimestamp()
            let albums = Array(value.results.compactMap({ $0 }) )
            albums.forEach { (album) in
                //Save to realm
                let rmAlbum = RMAlbum()
                rmAlbum.trackName = album.trackName ?? ""
                rmAlbum.artworkLarge = album.artworkLarge ?? ""
                rmAlbum.artworkMedium = album.artworkMedium ?? ""
                rmAlbum.artworkSmall = album.artworkSmall ?? ""
                rmAlbum.price.value = album.price
                rmAlbum.genre = album.genre ?? ""
                rmAlbum.desc = album.desc ?? ""
                rmAlbum.currency = album.currency ?? ""
                rmAlbum.trackId.value = album.trackId
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
