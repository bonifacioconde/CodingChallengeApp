//
//  DetailPresenter.swift
//  CodingChallengeApp
//
//  Created by Bonifacio Conde on 3/4/21.
//  Copyright © 2021 Boni. All rights reserved.
//

import UIKit

protocol DetailPresenter where Self: UIViewController {}

// MARK: - Methods

extension DetailPresenter {
  func presentDetailScreen(with albumCellVM: AlbumCellViewModelProtocol) {
    let lookUpNetwork = LookupNetwork(provider: LookupServiceProvider)
    let detailVM = DetailViewModel(
      albumCellVM: albumCellVM,
      network: lookUpNetwork
    )
    let detailVC = R.storyboard.main.detailController()!
    detailVC.viewModel = detailVM
    self.navigationController?.pushViewController(detailVC, animated: true)
  }
}
