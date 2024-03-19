//
//  SearchMainViewModel.swift
//  GitWorld
//
//  Created by Jiaxin Pu on 2024/1/30.
//

import Foundation
import Platform
import RxSwift
import RxCocoa
import Networking

class SearchTabViewModel: ViewModelType {
    
    struct Input {
        let searchRepository: Driver<String>
        let loadMoreRepository: Driver<Void>
    }
    
    struct Output {
        let cellModels: Driver<Result<[RepositoryCellModel], HttpError>>
    }
    
    private(set) var cellModels: [RepositoryCellModel] = []
    private let useCase: SearchTabUseCase
    private let navigator: SearchTabNavigator
    private var currentPageIndex: Int = 1
    private var currentKeyword: String?
    private let updateCellModelsSubject: PublishSubject<Result<[RepositoryCellModel], HttpError>> = .init()
    
    init(useCase: SearchTabUseCase, navigator: SearchTabNavigator) {
        self.useCase = useCase
        self.navigator = navigator
    }
    
    func transform(_ input: Input) -> Output {
        let searchResultRepositories = input.searchRepository.flatMapLatest { keyword in
            self.currentKeyword = keyword
            return self.useCase
                .requestRepositoriesList(keyWord: keyword, pageIndex: 1)
                .mapToResult { result in
                    return Result<[RepositoryCellModel], HttpError>.success(result.map { RepositoryCellModel(entity: $0) })
                }
                .asDriver(onErrorJustReturn: .failure(HttpError.serverError))
        }
        
        let loadMoreRepositories = input.loadMoreRepository.flatMapLatest { _ in
            self.currentPageIndex += 1
            return self.useCase
                .requestRepositoriesList(keyWord: self.currentKeyword ?? "", pageIndex: self.currentPageIndex)
                .mapToResult {[weak self] result in
                    let newCellModels = result.map { RepositoryCellModel(entity: $0) }
                    self?.cellModels.append(contentsOf: newCellModels)
                    return Result<[RepositoryCellModel], HttpError>.success(self?.cellModels ?? [])
                }.asDriver(onErrorJustReturn: .failure(HttpError.serverError))
        }
        
        let updateCellModelsDriver = updateCellModelsSubject.asDriver(onErrorJustReturn: .success([]))
        
        var cellModels = Driver.merge([searchResultRepositories, loadMoreRepositories, updateCellModelsDriver])
        cellModels = cellModels.do {[weak self] result in
            if case let .success(data) = result {
                self?.cellModels = data
                self?.updateCollectStatus()
            }
        }
        
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
    
    private func updateCollectStatus() {
        let collectedList = useCase.getCollectedRepositoriesList()
        for collectedRepository in collectedList {
            cellModels.first { $0.entity.id == collectedRepository.id }?.isCollected = true
        }
    }
}
