//
//  CollectTabViewModel.swift
//  GitWorld
//
//  Created by Jiaxin Pu on 2024/3/19.
//

import UIKit
import Platform
import RxSwift
import RxCocoa
import Networking

class CollectTabViewModel: ViewModelType {
    struct Input {
        let queryAllRepositories: Driver<Void>
    }
    
    struct Output {
        let cellModels: Driver<Result<[RepositoryCellModel], HttpError>>
    }
    
    private(set) var cellModels: [RepositoryCellModel] = []
    private let useCase: CollectTabUseCase
    private let navigator: CollectTabNavigator
    private let updateCellModelsSubject: PublishSubject<Result<[RepositoryCellModel], HttpError>> = .init()
    
    init(useCase: CollectTabUseCase, navigator: CollectTabNavigator) {
        self.useCase = useCase
        self.navigator = navigator
    }
    
    func transform(_ input: Input) -> Output {
        let queryAllRepositories = input.queryAllRepositories.flatMapLatest { _ in
            let entities = self.useCase.getCollectedRepositoriesList()
            let cellModels = entities.map { RepositoryCellModel(entity: $0) }
            cellModels.forEach { $0.isCollected = true }
            self.cellModels = cellModels
            return Driver<Result<[RepositoryCellModel], HttpError>>.just(.success(cellModels))
        }
        
        let updateCellModelsDriver = updateCellModelsSubject.asDriver(onErrorJustReturn: .success([]))
        let cellModels = Driver.merge([queryAllRepositories, updateCellModelsDriver])
        
        return Output(cellModels: cellModels)
    }
    
    func pushToRepositoryDetail(_ model: RepositoryEntity) {
        navigator.pushToRepositoryDetail(model)
    }
    
    func collectRepository(_ entity: RepositoryEntity) {
        useCase.collectRepository(entity)
        cellModels.first { $0.entity.id == entity.id }?.isCollected = true
        updateCellModelsSubject.onNext(.success(cellModels))
    }
    
    func uncollectRepository(_ entity: RepositoryEntity) {
        useCase.uncollectRepository(entity)
        cellModels.first { $0.entity.id == entity.id }?.isCollected = false
        updateCellModelsSubject.onNext(.success(cellModels))
    }
}
