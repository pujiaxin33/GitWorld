//
//  SearchTabCardView.swift
//  GitWorld
//
//  Created by Jiaxin Pu on 2024/5/17.
//

import SwiftUI

struct SearchTabCardView: View {
    let cellModel: RepositoryCellModel
    var collectButtonDidClicked: (() -> Void)?
    
    var body: some View {

        HStack {
            AsyncImage(url: URL(string: cellModel.entity.owner?.avatar_url ?? "")) { phase in
                if let image = phase.image {
                    image.resizable()
                        .background(Color.white)
                        .frame(width: 80, height: 80)
                        .cornerRadius(5)
                        .shadow(color: .black, radius: 5)
                } else {
                    Image(systemName: "books.vertical.circle")
                        .background(Color.white)
                        .frame(width: 80, height: 80)
                        .cornerRadius(5)
                        .shadow(color: .black, radius: 5)
                }
            }
            
            VStack(alignment: .leading) {
                Text(cellModel.entity.full_name ?? "")
                    .font(.title3)
                    .bold()
                Text(cellModel.entity.description ?? "")
                    .font(.caption)
                    .lineLimit(3)
                    .truncationMode(.tail)
                Text("\(cellModel.entity.stargazers_count ?? 0)")
                    .font(.caption)
            }
            
            Spacer()
            
            Button {
                collectButtonDidClicked?()
            } label: {
                if cellModel.isCollected {
                    Image(systemName: "heart.fill")
                        .foregroundColor(Color.blue)
                } else {
                    Image(systemName: "heart")
                        .foregroundColor(Color.blue)
                }
            }.buttonStyle(.plain)

        }
    }
}
