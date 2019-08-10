//
//  MasterViewController.swift
//  CodingApp
//
//  Created by Boni on 10/8/19.
//  Copyright © 2019 Boni. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var viewModel: MasterViewModel!
    var objects = [Any]()
    private var selectedIndexPath: IndexPath?
    private let cacheLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        clearsSelectionOnViewWillAppear = true
    }
    
    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let content = objects[indexPath.row]
        let viewCell: AlbumCell = tableView.dequeueReusableCell(for: indexPath)
        viewCell.configureCell(with: content as? Album)
        return viewCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.coordinatorDelegate?.showDetail(from: objects[indexPath.row] as? Album)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return cacheLabel
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
}

extension MasterViewController {
    func setupViewModel() {
        viewModel.resultClosure = { type in
            switch type {
            case .albums(let val):
                self.objects = val
                self.tableView.reloadData()
            case .cacheDate(let val):
                self.cacheLabel.text = val
            }
        }
        
        viewModel.loadData()
    }
}
