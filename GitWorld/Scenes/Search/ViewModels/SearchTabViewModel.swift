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
    }
    
    struct Output {
        let repositories: Driver<Result<[RepositoryModel], HttpError>>
    }
    
    private let useCase: SearchTabUseCase
    private let navigator: SearchTabNavigator
    
    init(useCase: SearchTabUseCase, navigator: SearchTabNavigator) {
        self.useCase = useCase
        self.navigator = navigator
    }
    
    
    func transform(_ input: Input) -> Output {
        let repositories = input.searchRepository.flatMapLatest {_ in 
            return self.useCase
                .requestRepositoriesList()
                .map { result in
                    return Result<[RepositoryModel], HttpError>.success(result)
                }.asDriver(onErrorJustReturn: .failure(.serverError))
        }
        
        return Output(repositories: repositories)
    }
}
