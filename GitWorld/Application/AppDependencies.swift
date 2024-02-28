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
}

class StandardAppDependencies: AppDependencies {
    let configuration = AppConfiguration()
    let apiClient: ApiClient
    
    init() {
        apiClient = StandardApiClient(baseUrl: configuration.baseUrl)
    }
}
