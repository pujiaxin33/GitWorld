//
//  CollectTabUseCase.swift
//  GitWorld
//
//  Created by Jiaxin Pu on 2024/3/19.
//

import Foundation

protocol CollectTabUseCase {
    func collectRepository(_ entity: RepositoryEntity)
    func uncollectRepository(_ entity: RepositoryEntity)
    func getCollectedRepositoriesList() -> [RepositoryEntity]
}

final class StandardCollectTabUseCase: CollectTabUseCase {
    let database: RepositoryDatabase
    
    init(database: RepositoryDatabase) {
        self.database = database
    }
    
    func collectRepository(_ entity: RepositoryEntity) {
        do {
            try database.save(entity)
        } catch (let error) {
            print(error.localizedDescription)
        }
    }
    
    func uncollectRepository(_ entity: RepositoryEntity) {
        do {
            try database.delete(entity)
        } catch (let error) {
            print(error.localizedDescription)
        }
    }
    
    func getCollectedRepositoriesList() -> [RepositoryEntity] {
        database.queryAll()
    }
}
