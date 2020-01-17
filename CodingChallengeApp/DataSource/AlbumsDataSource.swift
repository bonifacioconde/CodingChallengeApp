//
//  AlbumsDataSource.swift
//  CodingChallengeApp
//
//  Created by Bonz Condz on 17/01/2020.
//  Copyright © 2020 Boni. All rights reserved.
//

import UIKit

class AlbumsDataSource: GenericDataSource<RMAlbum>, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let content = data[indexPath.row]
        let viewCell: AlbumCell = tableView.dequeueReusableCell(for: indexPath)
        viewCell.configureCell(with: content)
        return viewCell
    }
    
}
