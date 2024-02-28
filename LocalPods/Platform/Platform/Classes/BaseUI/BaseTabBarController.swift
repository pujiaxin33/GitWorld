//
//  BaseTabBarController.swift
//  Platform
//
//  Created by Jiaxin Pu on 2024/2/28.
//

import UIKit

open class BaseTabBarController: UITabBarController {

    open override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBar()
    }
    
    private func setupTabBar() {
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.backgroundColor = .lightGray
            appearance.backgroundEffect = nil
            self.tabBar.scrollEdgeAppearance = appearance
            self.tabBar.standardAppearance = appearance
        } else {
            // Fallback on earlier versions
        }
    }
    
}
