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
    
    func requestRepositoriesList(keyWord: String, pageIndex: Int) -> Observable<[RepositoryEntity]> {
        let ob: Observable<RepositoryResult> = apiClient.request(.repositories(keyWord, pageIndex))
        return ob.map { result in
            result.items ?? []
        }
    }
    
}
