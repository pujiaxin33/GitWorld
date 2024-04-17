//
//  SettingsTabCellModel.swift
//  GitWorld
//
//  Created by Jiaxin Pu on 2024/4/17.
//

import Foundation

struct SettingsTabCellModel {
    enum CellType {
        case about
    }
    
    let cellType: CellType
    let icon: String
    let title: String
}
