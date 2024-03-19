//
//  AppCoordinator.swift
//  GitWorld
//
//  Created by Jiaxin Pu on 2024/2/23.
//

import Foundation
import UIKit
import Platform

final class AppCoordinator {
    private let dependencies: AppDependencies
    
    init(dependencies: AppDependencies) {
        self.dependencies = dependencies
    }
    
    func start(in window: UIWindow) {
        
        let searchNavigationController = UINavigationController()
        searchNavigationController.tabBarItem = .init(title: "搜索", image: .init(systemName: "plus.magnifyingglass"), selectedImage: nil)
        let searchCoordinator = SearchTabCoordinator(dependencies: dependencies, navigationController: searchNavigationController)
        searchCoordinator.start()
        
        let collectNavigationController = UINavigationController()
        collectNavigationController.tabBarItem = .init(title: "收藏", image: .init(systemName: "shippingbox"), selectedImage: nil)
        let collectCoordinator = CollectCoordinator(dependencies: dependencies, navigationController: collectNavigationController)
        collectCoordinator.start()
        
        let settingsNavigationController = UINavigationController()
        settingsNavigationController.tabBarItem = .init(title: "设置", image: .init(systemName: "gearshape"), selectedImage: nil)
        let settingsVC = BaseViewController()
        settingsVC.title = "设置"
        settingsNavigationController.viewControllers = [settingsVC]
        
        let tabBarController = BaseTabBarController()
        tabBarController.viewControllers = [
            searchNavigationController,
            collectNavigationController,
            settingsNavigationController
        ]
        
        window.overrideUserInterfaceStyle = .light
        window.rootViewController = tabBarController
    }
}
