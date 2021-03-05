//
//  AlbumCell.swift
//  CodingApp
//
//  Created by Boni on 10/8/19.
//  Copyright © 2019 Boni. All rights reserved.
//

import UIKit
import Kingfisher


class AlbumCell: UITableViewCell, ReusableView {
  var viewModel: AlbumCellViewModelProtocol! {
    didSet {
      refresh()
    }
  }
  
  @IBOutlet weak var genreLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var trackNameLabel: UILabel!
  @IBOutlet weak var artworkImageView: UIImageView!
  
  private let placeHolderImage = R.image.icSmallMoviePoster()
}

// MARK: - Helpers

private extension AlbumCell {
  func refresh() {
    
    guard viewModel != nil else { return }
    self.genreLabel.text = viewModel.genre
    self.trackNameLabel.text = viewModel.track
    let smallImage = viewModel.artworkURLString
    self.artworkImageView.processLink(smallImage,
                                      with: placeHolderImage)
    self.priceLabel.text = viewModel.price
  }
}
