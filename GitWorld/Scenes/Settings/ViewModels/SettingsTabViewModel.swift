//
//  SettingsTabViewModel.swift
//  GitWorld
//
//  Created by Jiaxin Pu on 2024/4/17.
//

import Foundation
import Platform
import RxCocoa

final class SettingsTabViewModel: ViewModelType {
    struct Input {
        let refreshCellModels: Driver<Void>
    }
    
    struct Output {
        let cellModels: Driver<[SettingsTabCellModel]>
    }
    
    private(set) var cellModels: [SettingsTabCellModel] = []
    
    let navigator: SettingsTabNavigator
    
    init(navigator: SettingsTabNavigator) {
        self.navigator = navigator
    }
    
    func transform(_ input: Input) -> Output {
        let cellModels = input.refreshCellModels.map { _ in
            self.cellModels = self.getCellModels()
            return self.cellModels
        }
        
        return Output(cellModels: cellModels)
    }
    
    func pushToAboutPage() {
        navigator.pushToAboutPage()
    }
    
    private func getCellModels() -> [SettingsTabCellModel] {
        return [.init(cellType: .about, icon: "info.circle", title: "关于")]
    }
}
