//
//  RepositoryCell.swift
//  GitWorld
//
//  Created by Jiaxin Pu on 2024/2/28.
//

import UIKit
import Kingfisher

class RepositoryCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI(_ entity: RepositoryEntity) {
        self.imageView?.kf.setImage(with: URL(string: entity.owner?.avatar_url ?? ""))
        self.textLabel?.text = entity.full_name
        self.detailTextLabel?.text = entity.description
    }
    
    private func setupViews() {
        
    }
}
