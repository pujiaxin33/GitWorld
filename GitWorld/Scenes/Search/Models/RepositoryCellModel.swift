//
//  RepositoryCell.swift
//  GitWorld
//
//  Created by Jiaxin Pu on 2024/3/6.
//

import Foundation

class RepositoryCellModel {
    let entity: RepositoryEntity
    var isCollected: Bool = false
    
    init(entity: RepositoryEntity) {
        self.entity = entity
    }
}
