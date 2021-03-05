//
//  DetailViewModelTests.swift
//  CodingChallengeAppTests
//
//  Created by Bonifacio Conde on 3/5/21.
//  Copyright © 2021 Boni. All rights reserved.
//

import Quick
import Nimble
@testable
import CodingChallengeApp

class DetailViewModelTests: QuickSpec {
  override func spec() {
    
    describe("DetailViewModelTest'") {
      var vm: DetailViewModel!
      var albumCellVM: MockAlbumCellViewModel!
      var valResult: DetailViewModelResult!
      
      beforeEach {
        albumCellVM = MockAlbumCellViewModel()
        vm = DetailViewModel(albumCellVM: albumCellVM)
        vm.resultClosure = { val in
          valResult = val
        }
      }
      
      it("must call setupDisplay resultClosure will receive value") {
        vm.setupDisplay()
        expect({
          guard case .genre = valResult else {
                return .failed(reason: "wrong enum case")
            }
            return .succeeded
        }).to(succeed())
        
        //expect(valResult).toEventually(equal(DetailViewModelResult.genre("")))
        //debugPrint(albumCellVM.album.desc)
        //debugPrint(vm.albumCellVM.album.desc)
      }
    }
  }
}

