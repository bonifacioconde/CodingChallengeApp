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
    var album: Album
    let lookupService: LookupService = LookupService()
    var resultClosure: ((DetailViewModelResult)->())?
    
    init(album: Album) {
        self.album = album
    }
    
    func setupDisplay() {
        func setupResult(from val: Album) {
            resultClosure?(.image(album.availableLargeImage()))
            resultClosure?(.description(album.description))
            resultClosure?(.price(album.priceFormatted()))
            resultClosure?(.name(album.trackName))
            resultClosure?(.genre(album.genre))
        }
        
        guard let trackId = album.trackId else {
            setupResult(from: album)
            return
        }
        
        let parameter = ParameterBuilder().add(value: "\(trackId)", for: LookupKey.id).build()
        lookupService.show(with: parameter, success:  { (items, cacheDate) in
            if let lookUpAlbum = items.compactMap({ Album(json: $0) }).first {
                setupResult(from: lookUpAlbum)
            }
        }, failure: {
            setupResult(from: self.album)
        })
    }
}
