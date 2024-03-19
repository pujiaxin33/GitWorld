//
//  SearchTabViewModelTests.swift
//  GitWorldTests
//
//  Created by Jiaxin Pu on 2024/3/19.
//

import XCTest
@testable import GitWorld

final class SearchTabViewModelTests: XCTestCase {
    var useCase: MockSearchTabUseCase!
    var navigator: MockSearchTabNavigator!
    var sut: SearchTabViewModel!
    
    override func setUpWithError() throws {
        useCase = MockSearchTabUseCase()
        navigator = MockSearchTabNavigator()
        sut = SearchTabViewModel(useCase: useCase, navigator: navigator)
    }

    override func tearDownWithError() throws {
        
    }

    func testWhenCollectRepositoryThenUseCaseCollectRepository() throws {
        // Given
        
        // When
        sut.collectRepository(.init(id: nil, full_name: nil, owner: nil, html_url: nil, description: nil, stargazers_count: nil))
        
        // Then
        XCTAssertTrue(useCase.isCollectRepositoryCalled)
    }
}
