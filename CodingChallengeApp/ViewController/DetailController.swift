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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupViewModel()

    }
}

extension DetailController {
    func setupViewModel() {
        viewModel.resultClosure = { type in
            switch type {
            case .image(let urlString):
                self.artworkImageView.processLink(urlString, with: UIImage(named: "ic-large-movie-poster"))
            case .description(let val):
                self.detailDescriptionLabel.text = "Description:\n\(val ?? "")"
            case .price(let val):
                self.priceLabel.text = "Price: \(val ?? "")"
            case .genre(let val):
                self.genreLabel.text = "Genre: \(val ?? "")"
            case .name(let val):
                self.trackNameLabel.text = "Track: \(val ?? "")"
            }
        }
        
        viewModel.setupDisplay()
    }
}
