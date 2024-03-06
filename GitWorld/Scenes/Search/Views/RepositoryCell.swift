//
//  RepositoryCell.swift
//  GitWorld
//
//  Created by Jiaxin Pu on 2024/2/28.
//

import UIKit
import Kingfisher
import SnapKit

class RepositoryCell: UITableViewCell {
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = UIColor.label
        return label
    }()
    private lazy var descLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .lightGray
        return label
    }()
    private lazy var starsLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .footnote)
        label.textColor = .black
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI(_ entity: RepositoryEntity) {
        self.iconImageView.kf.setImage(with: URL(string: entity.owner?.avatar_url ?? ""))
        self.nameLabel.text = entity.full_name
        self.descLabel.text = entity.description
        self.starsLabel.text = "stars:\(entity.stargazers_count ?? 0)"
    }
    
    private func setupViews() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(descLabel)
        contentView.addSubview(starsLabel)
        
        iconImageView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(16)
            make.width.height.equalTo(60)
        }
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(3)
            make.top.equalTo(iconImageView.snp.top)
            make.trailing.equalToSuperview().offset(-16)
        }
        descLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(3)
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.trailing.equalToSuperview().offset(-16)
        }
        starsLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(3)
            make.top.equalTo(descLabel.snp.bottom).offset(5)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
}
