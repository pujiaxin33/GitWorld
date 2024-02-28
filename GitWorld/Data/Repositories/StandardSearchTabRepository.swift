//
//  StandardSearchTabRepository.swift
//  GitWorld
//
//  Created by Jiaxin Pu on 2024/2/28.
//

import Foundation
import Networking
import RxSwift

class StandardSearchTabRepository: SearchTabRepository {
    let apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    func requestRepositoriesList(_ keyWord: String) -> Observable<[RepositoryEntity]> {
        let ob: Observable<RepositoryResult> = apiClient.request(.repositories(keyWord))
        return ob.map { result in
            result.items ?? []
        }
    }
    
}
