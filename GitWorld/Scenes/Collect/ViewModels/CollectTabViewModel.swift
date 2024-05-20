//
//  CollectTabViewModel.swift
//  GitWorld
//
//  Created by Jiaxin Pu on 2024/3/19.
//

import UIKit
import Platform
import Combine
import Networking

class CollectTabViewModel: ObservableObject {
    
    @Published var cellModels: [RepositoryCellModel] = []
    
    private let useCase: CollectTabUseCase
    private let navigator: CollectTabNavigator
    
    init(useCase: CollectTabUseCase, navigator: CollectTabNavigator) {
        self.useCase = useCase
        self.navigator = navigator
    }
    
    func loadData() {
        let entities = self.useCase.getCollectedRepositoriesList()
        let cellModels = entities.map { RepositoryCellModel(entity: $0) }
        cellModels.forEach { $0.isCollected = true }
        self.cellModels = cellModels
    }
    
    func pushToRepositoryDetail(_ model: RepositoryEntity) {
        navigator.pushToRepositoryDetail(model)
    }
    
    func collectRepository(_ entity: RepositoryEntity) {
        useCase.collectRepository(entity)
        cellModels.first { $0.entity.id == entity.id }?.isCollected = true
        self.cellModels = cellModels
    }
    
    func uncollectRepository(_ entity: RepositoryEntity) {
        useCase.uncollectRepository(entity)
        cellModels.removeAll(where: { $0.entity.id == entity.id })
        self.cellModels = cellModels
    }
}
