//
//  SettingsTabCoordinator.swift
//  GitWorld
//
//  Created by Jiaxin Pu on 2024/4/17.
//

import UIKit

final public class SettingsTabCoordinator {
    let dependecies: AppDependencies
    let navigationController: UINavigationController
    
    init(dependecies: AppDependencies, navigationController: UINavigationController) {
        self.dependecies = dependecies
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = SettingsTabViewController(viewModel: SettingsTabViewModel(navigator: self))
        navigationController.viewControllers = [vc]
    }
}

extension SettingsTabCoordinator: SettingsTabNavigator {
    func pushToAboutPage() {
        let vc = SettingsAboutViewController(viewModel: SettingsAboutViewModel())
        vc.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(vc, animated: true)
    }
}
