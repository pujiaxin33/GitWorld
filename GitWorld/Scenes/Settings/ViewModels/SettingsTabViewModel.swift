//
//  SettingsTabViewModel.swift
//  GitWorld
//
//  Created by Jiaxin Pu on 2024/4/17.
//

import Foundation
import Platform
import Combine

final class SettingsTabViewModel: ObservableObject {
    @Published var cellModels: [SettingsTabCellModel] = []
    
    let navigator: SettingsTabNavigator
    
    init(navigator: SettingsTabNavigator) {
        self.navigator = navigator
    }
    
    func loadData() {
        cellModels = getCellModels()
    }
    
    func pushToAboutPage() {
        navigator.pushToAboutPage()
    }
    
    private func getCellModels() -> [SettingsTabCellModel] {
        return [.init(cellType: .about, icon: "info.circle", title: "关于")]
    }
}
