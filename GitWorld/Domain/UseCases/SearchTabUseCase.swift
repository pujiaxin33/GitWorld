//
//  SearchTabUseCase.swift
//  GitWorld
//
//  Created by Jiaxin Pu on 2024/2/23.
//

import Foundation
import RxSwift

protocol SearchTabUseCase {
    func requestRepositoriesList(keyWord: String, pageIndex: Int) -> Observable<[RepositoryEntity]>
}

class StandardSearchTabUseCase: SearchTabUseCase {
    let repository: SearchTabRepository
    
    init(repository: SearchTabRepository) {
        self.repository = repository
    }
    
    func requestRepositoriesList(keyWord: String, pageIndex: Int) -> Observable<[RepositoryEntity]> {
        return repository
            .requestRepositoriesList(keyWord: keyWord, pageIndex: pageIndex)
    }
}
