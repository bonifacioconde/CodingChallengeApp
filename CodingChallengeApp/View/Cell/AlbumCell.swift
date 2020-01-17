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
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artworkImageView: UIImageView!
    
    private(set) var album: RMAlbum? {
        didSet {
            self.genreLabel.text = "Genre: \(album?.genre ?? "")"
            self.trackNameLabel.text = "Track: \(album?.trackName ?? "")"
            self.artworkImageView.processLink(album?.availableSmallImage(), with: UIImage(named: "ic-small-movie-poster"))
            self.priceLabel.text = "Price: \(album?.priceFormatted() ?? "")"
        }
    }
    
    func configureCell(with album: RMAlbum?) {
        self.album = album
    }
}
