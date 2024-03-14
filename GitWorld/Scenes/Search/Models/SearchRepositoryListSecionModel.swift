//
//  SearchRepositoryListSecionModel.swift
//  GitWorld
//
//  Created by Jiaxin Pu on 2024/3/7.
//

import Foundation
import RxDataSources

struct SearchRepositoryListSecionModel {
    var items: [RepositoryCellModel]
    
    init(items: [RepositoryCellModel]) {
        self.items = items
    }
}

extension SearchRepositoryListSecionModel: SectionModelType {
    init(original: SearchRepositoryListSecionModel, items: [RepositoryCellModel]) {
        self = original
        self.items = items
    }
}
