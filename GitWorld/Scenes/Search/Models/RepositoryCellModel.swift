//
//  RepositoryCell.swift
//  GitWorld
//
//  Created by Jiaxin Pu on 2024/3/6.
//

import Foundation

class RepositoryCellModel: Identifiable {
    
    let entity: RepositoryEntity
    var isCollected: Bool
    
    init(entity: RepositoryEntity, isCollected: Bool = false) {
        self.entity = entity
        self.isCollected = isCollected
    }
}
