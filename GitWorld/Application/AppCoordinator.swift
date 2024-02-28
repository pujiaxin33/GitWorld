//
//  AppCoordinator.swift
//  GitWorld
//
//  Created by Jiaxin Pu on 2024/2/23.
//

import Foundation
import UIKit

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
        
        let activityNavigationController = UINavigationController()
        activityNavigationController.tabBarItem = .init(title: "活动", image: .init(systemName: "bell"), selectedImage: nil)
        let activityVC = UIViewController()
        activityVC.title = "活动"
        activityNavigationController.viewControllers = [activityVC]
        
        let settingsNavigationController = UINavigationController()
        settingsNavigationController.tabBarItem = .init(title: "设置", image: .init(systemName: "bell"), selectedImage: nil)
        let settingsVC = UIViewController()
        settingsVC.title = "活动"
        settingsNavigationController.viewControllers = [settingsVC]
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
            searchNavigationController,
            activityNavigationController,
            settingsNavigationController
        ]
        
        window.overrideUserInterfaceStyle = .light
        window.rootViewController = tabBarController
    }
}
