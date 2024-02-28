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
    
    func requestRepositoriesList() -> Observable<[RepositoryEntity]> {
        let endpoint = StandardApiEndpoint(method: .get, path: "repositories", headers: nil, params: nil)
        return apiClient.request(endpoint)
    }
    
    
}
