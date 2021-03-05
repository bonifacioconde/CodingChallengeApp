//
//  DetailController.swift
//  CodingApp
//
//  Created by Boni on 10/8/19.
//  Copyright © 2019 Boni. All rights reserved.
//

import UIKit

class DetailController: UIViewController {
  
  var viewModel: DetailViewModel!
  
  @IBOutlet weak var genreLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var trackNameLabel: UILabel!
  @IBOutlet weak var artworkImageView: UIImageView!
  @IBOutlet weak var detailDescriptionLabel: UILabel!
  
  
}

// MARK: - Lifecycle

extension DetailController {
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    setupViewModel()
    
  }
}

// MARK: - Setup

extension DetailController {
  func setupViewModel() {
    viewModel.resultClosure = { type in
      switch type {
      case .image(let urlString):
        self.artworkImageView.processLink(urlString, with: R.image.icLargeMoviePoster())
      case .description(let val):
        self.detailDescriptionLabel.text = val
      case .price(let val):
        self.priceLabel.text = val
      case .genre(let val):
        self.genreLabel.text = val
      case .name(let val):
        self.trackNameLabel.text = val
      }
    }
    
    viewModel.setupDisplay()
  }
}
