//
//  MasterViewController.swift
//  CodingApp
//
//  Created by Boni on 10/8/19.
//  Copyright © 2019 Boni. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    lazy var listDataSource: AlbumsDataSource = {
        let source = AlbumsDataSource()
        self.viewModel = MasterViewModel(source: source)
        self.viewModel.coordinatorDelegate = self
        return source
    }()
    
    var viewModel: MasterViewModel!
    private var selectedIndexPath: IndexPath?
    private let cacheLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = listDataSource
        setupViewModel()
        
        refreshControl?.addTarget(self, action: #selector(doSomething), for: .valueChanged)

        // this is the replacement of implementing: "collectionView.addSubview(refreshControl)"
        tableView.refreshControl = refreshControl
    }
    
    @objc func doSomething(refreshControl: UIRefreshControl) {
        viewModel.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        clearsSelectionOnViewWillAppear = true
    }
    
    // MARK: - Table View
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.coordinatorDelegate?.showDetail(from: listDataSource.data[indexPath.row])
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
            case .done:
                self.tableView.reloadData()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.refreshControl?.endRefreshing()
                }
            case .cacheDate(let val):
                self.cacheLabel.text = val
            }
        }
        
        viewModel.loadData()
    }
}


extension MasterViewController: MasterViewCoordinatorDelegate {
    func showDetail(from album: RMAlbum?) {
        guard let album = album else {
            return
        }
        
        let detailViewModel = DetailViewModel(album: album)
        let vc = DetailViewController.instantiate(fromAppStoryboard: .main)
        vc.viewModel = detailViewModel
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
