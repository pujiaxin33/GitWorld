//
//  SettingsTabCellModel.swift
//  GitWorld
//
//  Created by Jiaxin Pu on 2024/4/17.
//

import Foundation

struct SettingsTabCellModel: Identifiable {
    enum CellType {
        case about
    }
    
    var id: String {
        return title + icon
    }
    let cellType: CellType
    let icon: String
    let title: String
}
