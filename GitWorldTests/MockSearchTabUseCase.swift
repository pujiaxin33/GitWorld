//
//  MockSearchTabUseCase.swift
//  GitWorldTests
//
//  Created by Jiaxin Pu on 2024/3/19.
//

import Foundation
@testable import GitWorld
import RxSwift

class MockSearchTabUseCase: SearchTabUseCase {
    var isCollectRepositoryCalled: Bool = false
    func requestRepositoriesList(keyWord: String, pageIndex: Int) -> RxSwift.Observable<[GitWorld.RepositoryEntity]> {
        return .just([])
    }
    
    func collectRepository(_ entity: GitWorld.RepositoryEntity) {
        isCollectRepositoryCalled = true
    }
    
    func uncollectRepository(_ entity: GitWorld.RepositoryEntity) {
        
    }
    
    func getCollectedRepositoriesList() -> [GitWorld.RepositoryEntity] {
        return []
    }
}

