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
    func collectRepository(_ entity: RepositoryEntity)
    func getCollectedRepositoriesList() -> [RepositoryEntity]
}

class StandardSearchTabUseCase: SearchTabUseCase {
    let repository: SearchTabRepository
    let database: RepositoryDatabase
    
    init(repository: SearchTabRepository, database: RepositoryDatabase) {
        self.repository = repository
        self.database = database
    }
    
    func requestRepositoriesList(keyWord: String, pageIndex: Int) -> Observable<[RepositoryEntity]> {
        return repository
            .requestRepositoriesList(keyWord: keyWord, pageIndex: pageIndex)
    }
    
    func collectRepository(_ entity: RepositoryEntity) {
        do {
            try database.save(entity)
        } catch (let error) {
            print(error.localizedDescription)
        }
    }
    
    func getCollectedRepositoriesList() -> [RepositoryEntity] {
        database.queryAll()
    }
}
