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
        let searchResultRepositories: Driver<Result<[RepositoryCellModel], HttpError>>
        let loadMoreRepositories: Driver<Result<[RepositoryCellModel], HttpError>>
//        let updatedRepositories: Driver<Result<[RepositoryCellModel], HttpError>>
    }
    
    private let useCase: SearchTabUseCase
    private let navigator: SearchTabNavigator
    private var currentPageIndex: Int = 1
    private var currentKeyword: String?
    
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
                .mapToResult { result in
                    return Result<[RepositoryCellModel], HttpError>.success(result.map { RepositoryCellModel(entity: $0) })
                }.asDriver(onErrorJustReturn: .failure(HttpError.serverError))
        }
        
        return Output(searchResultRepositories: searchResultRepositories, loadMoreRepositories: loadMoreRepositories)
    }
    
    func pushToRepositoryDetail(_ model: RepositoryEntity) {
        navigator.pushToRepositoryDetail(model)
    }
    
    func collectRepository(_ entity: RepositoryEntity) {
        useCase.collectRepository(entity)
    }
}
