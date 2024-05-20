//
//  SearchTabPageView.swift
//  GitWorld
//
//  Created by Jiaxin Pu on 2024/4/19.
//

import SwiftUI
import Combine

struct SearchTabPageView: View {
    @ObservedObject var viewModel: SearchTabViewModel
    @State private var searchText = ""
    
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
            if !viewModel.hasMoreData {
                HStack() {
                    Spacer()
                    ProgressView("正在加载...")
                        .onAppear {
                            viewModel.loadMore()
                        }
                    Spacer()
                }
            }
        }
        .searchable(text: $searchText)
        .onChange(of: searchText) { newValue in
            viewModel.sendAction(.search(newValue))
        }
        
    }
    
}
