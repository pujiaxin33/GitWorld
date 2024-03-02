//
//  SearchTabViewController+TableView.swift
//  GitWorld
//
//  Created by Jiaxin Pu on 2024/2/28.
//

import UIKit
import Platform

extension SearchTabViewController {
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.estimatedRowHeight = 50
        tableView.register(RepositoryCell.self, forCellReuseIdentifier: RepositoryCell.reuseIdentifier)
        
    }
}

extension SearchTabViewController: UITableViewDelegate {
    
}

extension SearchTabViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryCell.reuseIdentifier, for: indexPath) as! RepositoryCell
        cell.updateUI(repositoryList[indexPath.row])
        return cell
    }
    
    
}
