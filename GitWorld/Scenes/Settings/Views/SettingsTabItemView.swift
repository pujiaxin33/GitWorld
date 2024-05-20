//
//  SettingsTabSettingsItemView.swift
//  GitWorld
//
//  Created by Jiaxin Pu on 2024/5/20.
//

import SwiftUI

struct SettingsTabItemView: View {
    let cellModel: SettingsTabCellModel
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: cellModel.icon)
                .frame(width: 30, height: 30)
            
            Text(cellModel.title)
            
            Spacer()
            
            Image(systemName: "arrow.forward").padding(.init(top: 0, leading: 0, bottom: 0, trailing: 5))
        }
    }
}

#Preview {
    SettingsTabItemView(cellModel: .init(cellType: .about, icon: "info.circle", title: "关于"))
}
