//
//  AppDependencies.swift
//  GitWorld
//
//  Created by Jiaxin Pu on 2024/2/23.
//

import Foundation
import Networking

protocol AppDependencies {
    var apiClient: ApiClient { get }
    var repositoryDatabase: RepositoryDatabase { get }
}

class StandardAppDependencies: AppDependencies {
    let configuration = AppConfiguration()
    let apiClient: ApiClient
    let repositoryDatabase: RepositoryDatabase
    
    init() {
        apiClient = StandardApiClient(baseUrl: configuration.baseUrl)
        repositoryDatabase = StandardRepositoryDatabase()
        try? repositoryDatabase.createTable()
    }
}
