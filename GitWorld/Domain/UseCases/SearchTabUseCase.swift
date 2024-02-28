//
//  SearchTabUseCase.swift
//  GitWorld
//
//  Created by Jiaxin Pu on 2024/2/23.
//

import Foundation
import RxSwift

protocol SearchTabUseCase {
    func requestRepositoriesList() -> Observable<[RepositoryModel]>
}

class StandardSearchTabUseCase: SearchTabUseCase {
    let repository: SearchTabRepository
    
    init(repository: SearchTabRepository) {
        self.repository = repository
    }
    
    func requestRepositoriesList() -> Observable<[RepositoryModel]> {
        return repository
            .requestRepositoriesList()
            .map { entities in
            entities.map { RepositoryModel(from: $0) }
        }
    }
}
