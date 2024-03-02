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
                .mapToResult { result in
                    return Result<[RepositoryEntity], HttpError>.success(result)
                }
//                .map { result in
//                    return Result<[RepositoryEntity], HttpError>.success(result)
//                }
//                .catch { error in
//                    Observable.just(Result.failure(HttpError.someError(error)))
//                }
                .asDriver(onErrorJustReturn: .failure(HttpError.serverError))
        }
        
        return Output(repositories: repositories)
    }
}

extension ObservableType {
    func mapToResult<T>(_ transform: @escaping (Element) throws -> Result<T, HttpError>) -> Observable<Result<T, HttpError>> {
        return self.map { e in
            try transform(e)
        }.catch { error in
            Observable.just(Result.failure(HttpError.someError(error)))
        }
    }
}
