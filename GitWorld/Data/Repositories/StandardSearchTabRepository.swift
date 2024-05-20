//
//  StandardSearchTabRepository.swift
//  GitWorld
//
//  Created by Jiaxin Pu on 2024/2/28.
//

import Foundation
import Networking
import Combine

class StandardSearchTabRepository: SearchTabRepository {
    let apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    func requestRepositoriesList(keyWord: String, pageIndex: Int) -> AnyPublisher<[RepositoryEntity], HttpError> {
        let ob: AnyPublisher<RepositoryResult, HttpError> = apiClient.request(.repositories(keyWord, pageIndex))
        return ob.map { result in
            result.items ?? []
        }.eraseToAnyPublisher()
    }
    
}
