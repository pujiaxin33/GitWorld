//
//  SettingsTabPageView.swift
//  GitWorld
//
//  Created by Jiaxin Pu on 2024/5/20.
//

import SwiftUI

struct SettingsTabPageView: View {
    let viewModel: SettingsTabViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.cellModels) { cellModel in
                SettingsTabItemView(cellModel: cellModel)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        viewModel.pushToAboutPage()
                    }
            }
        }
    }
}
