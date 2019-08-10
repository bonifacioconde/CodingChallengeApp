//
//  MasterViewModel.swift
//  CodingApp
//
//  Created by Boni on 10/8/19.
//  Copyright © 2019 Boni. All rights reserved.
//

import Foundation

enum MasterViewModelResult {
    case albums([Album])
    case cacheDate(String)
}

protocol MasterViewCoordinatorDelegate {
    func showDetail(from album: Album?)
}

class MasterViewModel {
    let searchService: SearchService = SearchService()
    
    var coordinatorDelegate: MasterViewCoordinatorDelegate?
    var resultClosure: ((MasterViewModelResult)->())?
    
    func loadData() {
        let parameters = ParameterBuilder()
            .add(value: "star", for: SearchKey.term)
            .add(value: "au", for: SearchKey.country)
            .add(value: "movie", for: SearchKey.media)
            .limit("40")
            .build()
        searchService.list(with: parameters, complete: { (values, cacheDate) in
            let albums = values.compactMap({ Album(json: $0) })
            self.resultClosure?(.albums(albums))
            self.resultClosure?(.cacheDate(cacheDate))
        })
    }
}
