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
        let repositories: Driver<Result<[RepositoryEntity], HttpError>>
    }
    
    private let useCase: SearchTabUseCase
    private let navigator: SearchTabNavigator
    
    init(useCase: SearchTabUseCase, navigator: SearchTabNavigator) {
        self.useCase = useCase
        self.navigator = navigator
    }
    
    
    func transform(_ input: Input) -> Output {
        let repositories = input.searchRepository.flatMapLatest { keyword in
            return self.useCase
                .requestRepositoriesList(keyword)
                .map { result in
                    return Result<[RepositoryEntity], HttpError>.success(result)
                }
                .catch { error in
                    print(error)
                    return Observable.create { observer in
                        observer.onNext(Result<[RepositoryEntity], HttpError>.failure(HttpError.serverError))
                        return Disposables.create {}
                    }
                }
                .asDriver(onErrorJustReturn: .failure(HttpError.serverError))
        }
        
        return Output(repositories: repositories)
    }
}
