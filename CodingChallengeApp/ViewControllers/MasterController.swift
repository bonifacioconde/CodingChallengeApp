//
//  MasterController.swift
//  CodingApp
//
//  Created by Boni on 10/8/19.
//  Copyright © 2019 Boni. All rights reserved.
//

import UIKit

class MasterController: UITableViewController {
  
  lazy var albumDataSource: AlbumsDataSource = {
    let source = AlbumsDataSource()
    let network = SearchNetwork(provider: SearchServiceProvider)
    self.viewModel = MasterViewModel(source: source, network: network)
    self.viewModel.coordinatorDelegate = self
    return source
  }()
  
  var viewModel: MasterViewModel!
  private var selectedIndexPath: IndexPath?
  private let cacheLabel = UILabel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.dataSource = albumDataSource
    setupViewModel()
    
    refreshControl?.addTarget(self, action: #selector(doSomething), for: .valueChanged)
    
    // this is the replacement of implementing: "collectionView.addSubview(refreshControl)"
    tableView.refreshControl = refreshControl
  }
  
  @objc func doSomething(refreshControl: UIRefreshControl) {
    viewModel.setupData()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    clearsSelectionOnViewWillAppear = true
  }
  
  // MARK: - Table View
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    viewModel.coordinatorDelegate?.masterShowDetail(from: albumDataSource.data[indexPath.row])
  }
  
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    return cacheLabel
  }
  
  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 44
  }
}

extension MasterController {
  func setupViewModel() {
    viewModel.resultClosure = { type in
      switch type {
      case .done:
        self.tableView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
          self.refreshControl?.endRefreshing()
        }
      case .cacheDate(let val):
        self.cacheLabel.text = val
      }
    }
    
    viewModel.setupData()
  }
}


extension MasterController: MasterViewCoordinatorDelegate {
  func masterShowDetail(from album: RMAlbum?) {
    guard let album = album else {
      return
    }
    
    let detailVM = DetailViewModel(album: album)
    let detailVC = DetailController.instantiate(fromAppStoryboard: .main)
    detailVC.viewModel = detailVM
    self.navigationController?.pushViewController(detailVC, animated: true)
  }
}
