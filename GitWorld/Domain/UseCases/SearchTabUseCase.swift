//
//  SearchTabUseCase.swift
//  GitWorld
//
//  Created by Jiaxin Pu on 2024/2/23.
//

import Foundation
import RxSwift

protocol SearchTabUseCase {
    func requestRepositoriesList(_ keyWord: String) -> Observable<[RepositoryEntity]>
}

class StandardSearchTabUseCase: SearchTabUseCase {
    let repository: SearchTabRepository
    
    init(repository: SearchTabRepository) {
        self.repository = repository
    }
    
    func requestRepositoriesList(_ keyWord: String) -> Observable<[RepositoryEntity]> {
        return repository
            .requestRepositoriesList(keyWord)
    }
}
