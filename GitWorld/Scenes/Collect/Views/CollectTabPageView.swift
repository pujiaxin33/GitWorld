//
//  CollectTabPageView.swift
//  GitWorld
//
//  Created by Jiaxin Pu on 2024/5/20.
//

import SwiftUI

struct CollectTabPageView: View {
    @ObservedObject var viewModel: CollectTabViewModel
    
    var body: some View {
        List() {
            ForEach(viewModel.cellModels) { cellModel in
                SearchTabCardView(cellModel: cellModel) {
                    if cellModel.isCollected {
                        viewModel.uncollectRepository(cellModel.entity)
                    } else {
                        viewModel.collectRepository(cellModel.entity)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    viewModel.pushToRepositoryDetail(cellModel.entity)
                }
            }
        }
    }
}
