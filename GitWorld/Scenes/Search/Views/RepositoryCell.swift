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
    var clickCollectButtonCallback: ((Bool) -> Void)?
    
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
    private lazy var collectButton: UIButton = {
        let button = UIButton()
        button.contentMode = .scaleAspectFit
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        button.tintColor = .brown
        button.addTarget(self, action: #selector(onClickCollectButton), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI(_ cellModel: RepositoryCellModel) {
        let entity = cellModel.entity
        self.iconImageView.kf.setImage(with: URL(string: entity.owner?.avatar_url ?? ""))
        self.nameLabel.text = entity.full_name
        self.descLabel.text = entity.description
        self.starsLabel.text = "stars:\(entity.stargazers_count ?? 0)"
        collectButton.isSelected = cellModel.isCollected
    }
    
    private func setupViews() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(descLabel)
        contentView.addSubview(starsLabel)
        contentView.addSubview(collectButton)
        
        iconImageView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(16)
            make.width.height.equalTo(60)
        }
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(3)
            make.top.equalTo(iconImageView.snp.top)
            make.trailing.equalTo(collectButton.snp.leading).offset(-5)
        }
        descLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(3)
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.trailing.equalTo(collectButton.snp.leading).offset(-5)
        }
        starsLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(3)
            make.top.equalTo(descLabel.snp.bottom).offset(5)
            make.trailing.equalTo(collectButton.snp.leading).offset(-5)
        }
        collectButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(25)
        }
    }
    
    @objc private func onClickCollectButton() {
        clickCollectButtonCallback?(collectButton.isSelected)
    }
}
