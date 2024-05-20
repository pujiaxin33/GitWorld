//
//  SearchRepositoryListSecionModel.swift
//  GitWorld
//
//  Created by Jiaxin Pu on 2024/3/7.
//

import Foundation

struct SearchRepositoryListSecionModel {
    var items: [RepositoryCellModel]
    
    init(items: [RepositoryCellModel]) {
        self.items = items
    }
}
