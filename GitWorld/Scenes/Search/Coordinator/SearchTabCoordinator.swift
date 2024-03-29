//
//  SearchTabCoordinator.swift
//  GitWorld
//
//  Created by Jiaxin Pu on 2024/2/23.
//

import UIKit

final class SearchTabCoordinator {
    private let dependencies: AppDependencies
    private let navigationController: UINavigationController
    
    init(dependencies: AppDependencies, navigationController: UINavigationController) {
        self.dependencies = dependencies
        self.navigationController = navigationController
    }
    
    func start() {
        let repository = StandardSearchTabRepository(apiClient: dependencies.apiClient)
        let useCase = StandardSearchTabUseCase(repository: repository, database: dependencies.repositoryDatabase)
        let viewModel = SearchTabViewModel(useCase: useCase, navigator: self)
        let viewController = SearchTabViewController(viewModel: viewModel)
        navigationController.viewControllers = [viewController]
    }
}

extension SearchTabCoordinator: SearchTabNavigator {
    func pushToRepositoryDetail(_ model: RepositoryEntity) {
        let viewModel = RepositoryDetailViewModel(repositoryEntity: model)
        let vc = RepositoryDetailViewController(viewModel: viewModel)
        vc.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(vc, animated: true)
    }
}
