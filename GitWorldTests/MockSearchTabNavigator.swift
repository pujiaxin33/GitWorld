//
//  MockSearchTabNavigator.swift
//  GitWorldTests
//
//  Created by Jiaxin Pu on 2024/3/19.
//

import Foundation
@testable import GitWorld

class MockSearchTabNavigator: SearchTabNavigator {
    var isPushToRepositoryDetailCalled: Bool = false
    
    func pushToRepositoryDetail(_ model: GitWorld.RepositoryEntity) {
        isPushToRepositoryDetailCalled = true
    }
}
