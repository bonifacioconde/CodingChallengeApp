//
//  DetailControllerUISpec.swift
//  CodingChallengeAppTests
//
//  Created by Bonz Condz on 16/04/2020.
//  Copyright © 2020 Boni. All rights reserved.
//


import Quick
import Nimble
@testable
import CodingChallengeApp
import Moya

class DetailControllerUISpec: QuickSpec {
  
  override func spec() {
    
    var controller: DetailController!
    var viewModel: DetailViewModel!

    describe("The 'Detail Controller Test'") {
      context("Can show screen") {
        ///
        afterEach {
          controller = nil
          viewModel = nil
        }
        
        ///
        beforeEach {
          if let url = Bundle.main.path(forResource: "detail", ofType: "json") {
            let jsonData = try! Data(contentsOf: URL(fileURLWithPath: url))
            let albums = try! JSONDecoder().decode(AlbumResult.self, from: jsonData)
            if let album = albums.results.first {
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
              
              viewModel = DetailViewModel(album: rmAlbum)
              controller = DetailController.instantiate(fromAppStoryboard: .main)
              controller.viewModel = viewModel
              _ = controller.view
            }
          }
        }
        
        ///
        it("should have shown screen") {
          expect(controller).toNot(beNil())
        }
        
        it("should have shown data") {
          expect(viewModel.album.desc).toNot(beEmpty())
          
        }
      }
    }
  }
}

