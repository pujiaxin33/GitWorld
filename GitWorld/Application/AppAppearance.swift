//
//  AppAppearance.swift
//  GitWorld
//
//  Created by Jiaxin Pu on 2024/2/23.
//

import Foundation
import UIKit

final class AppAppearance {
    
    static func setupAppearance() {
        setupNavigationBar()
        setupTabbar()
    }
    
    private static func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    private static func setupTabbar() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .black
        
    }
}

extension UINavigationController {
    @objc override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
