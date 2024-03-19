//
//  CollectTabViewController+TableView.swift
//  GitWorld
//
//  Created by Jiaxin Pu on 2024/3/19.
//

import UIKit
import Platform
import RxCocoa
import RxDataSources

extension CollectTabViewController {
    private var repositoryList: [RepositoryCellModel] {
        self.viewModel.cellModels
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RepositoryCell.self, forCellReuseIdentifier: RepositoryCell.reuseIdentifier)
    }
}

extension CollectTabViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellModel = repositoryList[indexPath.row]
        viewModel.pushToRepositoryDetail(cellModel.entity)
    }
}

extension CollectTabViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryCell.reuseIdentifier, for: indexPath) as! RepositoryCell
        let cellModel = repositoryList[indexPath.row]
        cell.updateUI(cellModel)
        cell.clickCollectButtonCallback = { [weak self] isCollected in
            if isCollected {
                self?.viewModel.uncollectRepository(cellModel.entity)
            } else {
                self?.viewModel.collectRepository(cellModel.entity)
            }
        }
        return cell
    }
}

