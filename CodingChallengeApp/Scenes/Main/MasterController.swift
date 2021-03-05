//
//  MasterController.swift
//  CodingApp
//
//  Created by Boni on 10/8/19.
//  Copyright © 2019 Boni. All rights reserved.
//

import UIKit

class MasterController: UITableViewController, DetailPresenter {
  var viewModel: MasterViewModel!
  private var selectedIndexPath: IndexPath?
  private let cacheLabel = UILabel()
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    clearsSelectionOnViewWillAppear = true
  }
  
  // MARK: - Table View
  override func tableView(
    _ tableView: UITableView,
    didSelectRowAt indexPath: IndexPath
  ) {
    let album = viewModel.dataSource.data[indexPath.row]
    self.presentDetailScreen(with: album)
  }
  
  override func tableView(
    _ tableView: UITableView,
    viewForHeaderInSection section: Int
  ) -> UIView? {
    return cacheLabel
  }
  
  override func tableView(
    _ tableView: UITableView,
    heightForHeaderInSection section: Int
  ) -> CGFloat {
    return 44
  }
}

// MARK: - Lifecycle

extension MasterController {
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.dataSource = viewModel.dataSource
    setupViewModel()
    
    refreshControl?.addTarget(
      self,
      action: #selector(doSomething),
      for: .valueChanged
    )
    
    // this is the replacement of implementing: "collectionView.addSubview(refreshControl)"
    tableView.refreshControl = refreshControl
  }
}

// MARK: - Setup

extension MasterController {
  func setupViewModel() {
    viewModel.resultClosure = { type in
      switch type {
      case .done:
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
      case .cacheDate(let val):
        self.cacheLabel.text = val
      }
    }
    
    viewModel.setupData()
  }
}

// MARK: - Actions

private extension MasterController {
  @objc
  func doSomething(refreshControl: UIRefreshControl) {
    viewModel.setupData()
  }
}
