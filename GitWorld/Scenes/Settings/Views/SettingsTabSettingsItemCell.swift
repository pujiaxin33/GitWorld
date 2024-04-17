//
//  SettingsTabSettingsItemCell.swift
//  GitWorld
//
//  Created by Jiaxin Pu on 2024/4/17.
//

import UIKit

class SettingsTabSettingsItemCell: UITableViewCell {
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI(_ cellModel: SettingsTabCellModel) {
        self.iconImageView.image = UIImage(systemName: cellModel.icon)
        self.nameLabel.text = cellModel.title
    }
    
    private func setupViews() {
        selectionStyle = .none
        contentView.addSubview(iconImageView)
        contentView.addSubview(nameLabel)
        
        iconImageView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(10)
            make.width.height.equalTo(35)
        }
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(10)
            make.centerY.equalTo(iconImageView)
        }
    }

}
