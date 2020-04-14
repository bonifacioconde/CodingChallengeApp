//
//  DetailViewModel.swift
//  CodingApp
//
//  Created by Boni on 10/8/19.
//  Copyright © 2019 Boni. All rights reserved.
//

import UIKit

enum DetailViewModelResult {
    case image(String?)
    case description(String?)
    case price(String?)
    case name(String?)
    case genre(String?)
}

class DetailViewModel {
    var album: RMAlbum
    let lookupNetwork: LookupNetwork = LookupNetwork()
    var resultClosure: ((DetailViewModelResult) -> Void)?
    
    init(album: RMAlbum) {
        self.album = album
    }
    
    func setupDisplay() {
        func setupResult(from val: RMAlbum) {
            resultClosure?(.image(album.availableLargeImage()))
            resultClosure?(.description(album.desc))
            resultClosure?(.price(album.priceFormatted()))
            resultClosure?(.name(album.trackName))
            resultClosure?(.genre(album.genre))
        }
        
        guard let trackId = album.trackId.value else {
            setupResult(from: album)
            return
        }
        
        let parameter = ParameterBuilder().add(value: "\(trackId)", for: LookupKey.id).build()
        lookupNetwork.show(with: parameter, success: { (values) in
            if let lookUpAlbum = Array(values.results.compactMap({ $0 })).first {
                
                //Save to realm
                let rmAlbum = RMAlbum()
                rmAlbum.trackName = lookUpAlbum.trackName ?? ""
                rmAlbum.artworkLarge = lookUpAlbum.artworkLarge ?? ""
                rmAlbum.artworkMedium = lookUpAlbum.artworkMedium ?? ""
                rmAlbum.artworkSmall = lookUpAlbum.artworkSmall ?? ""
                rmAlbum.price.value = lookUpAlbum.price
                rmAlbum.genre = lookUpAlbum.genre ?? ""
                rmAlbum.desc = lookUpAlbum.desc ?? ""
                rmAlbum.currency = lookUpAlbum.currency ?? ""
                rmAlbum.trackId.value = lookUpAlbum.trackId 
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
