//
//  SearchTabViewController+TableView.swift
//  GitWorld
//
//  Created by Jiaxin Pu on 2024/2/28.
//

import UIKit
import Platform
import RxCocoa
import RxDataSources

extension SearchTabViewController {
    private var repositoryList: [RepositoryCellModel] {
        self.viewModel.cellModels
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RepositoryCell.self, forCellReuseIdentifier: RepositoryCell.reuseIdentifier)
    }
}

extension SearchTabViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellModel = repositoryList[indexPath.row]
        viewModel.pushToRepositoryDetail(cellModel.entity)
    }
}

extension SearchTabViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryCell.reuseIdentifier, for: indexPath) as! RepositoryCell
        let cellModel = repositoryList[indexPath.row]
        cell.updateUI(cellModel)
        cell.clickCollectButtonCallback = { [weak self] in
            self?.viewModel.collectRepository(cellModel.entity)
        }
        return cell
    }
}
