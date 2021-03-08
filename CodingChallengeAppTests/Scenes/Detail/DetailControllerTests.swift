//
//  DetailControllerTests.swift
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


class DetailControllerTests: QuickSpec {
  
  override func spec() {
    describe("DetailControllerTest") {
      var vc: DetailController!
      var vm: DetailViewModel!
      
      beforeEach {
        vc = R.storyboard.main.detailController()!
        vm = DetailViewModel(albumCellVM: MockAlbumCellViewModel())
        vc.viewModel = vm
      }
      
      context("when view is loaded") {
        
        beforeEach {
          vc.loadViewIfNeeded()
        }

        afterEach {
          vc = nil
          vm = nil
        }
        
        it("should have non-nil properties") {
          expect(vc.genreLabel).toNot(beNil())
          expect(vc.detailDescriptionLabel).toNot(beNil())
          expect(vc.artworkImageView).toNot(beNil())
          expect(vc.priceLabel).toNot(beNil())
          expect(vc.trackNameLabel).toNot(beNil())
        }
        
        ///
        it("should have shown screen") {
          expect(vc).toNot(beNil())
        }
        
        it("should have shown data") {
          expect(vc.detailDescriptionLabel.text).toNot(beNil())
          expect(vc.priceLabel.text).toNot(beNil())
          expect(vc.trackNameLabel.text).toNot(beNil())
          expect(vc.genreLabel.text).toNot(beNil())
          expect(vc.artworkImageView.image).toNot(beNil())
        }
      }
    }
  }
}

