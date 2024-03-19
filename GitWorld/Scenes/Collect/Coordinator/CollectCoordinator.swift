//
//  CollectCoordinator.swift
//  GitWorld
//
//  Created by Jiaxin Pu on 2024/3/19.
//

import UIKit

final class CollectCoordinator {
    private let dependencies: AppDependencies
    private let navigationController: UINavigationController
    
    init(dependencies: AppDependencies, navigationController: UINavigationController) {
        self.dependencies = dependencies
        self.navigationController = navigationController
    }
    
    func start() {
        let useCase = StandardCollectTabUseCase(database: dependencies.repositoryDatabase)
        let viewModel = CollectTabViewModel(useCase: useCase, navigator: self)
        let viewController = CollectTabViewController(viewModel: viewModel)
        navigationController.viewControllers = [viewController]
    }
}

extension CollectCoordinator: CollectTabNavigator {
    func pushToRepositoryDetail(_ model: RepositoryEntity) {
        let viewModel = RepositoryDetailViewModel(repositoryEntity: model)
        let vc = RepositoryDetailViewController(viewModel: viewModel)
        vc.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(vc, animated: true)
    }
}
