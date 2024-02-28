//
//  RepositoryModel.swift
//  GitWorld
//
//  Created by Jiaxin Pu on 2024/2/28.
//

import Foundation

struct RepositoryModel {
    let name: String
    let starts: Int
    let homePage: String
}

extension RepositoryModel {
    init(from entity: RepositoryEntity) {
        self.name = entity.name
        self.starts = entity.starts
        self.homePage = entity.homePage
    }
}
