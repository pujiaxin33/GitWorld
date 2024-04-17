//
//  SettingsAboutViewController.swift
//  GitWorld
//
//  Created by Jiaxin Pu on 2024/4/17.
//

import UIKit
import Platform
import SnapKit

class SettingsAboutViewController: BaseViewController {
    let viewModel: SettingsAboutViewModel
    private lazy var infoTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 12)
        textView.textAlignment = .center
        textView.isEditable = false
        return textView
    }()
    
    init(viewModel: SettingsAboutViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "关于"
        viewModel.refreshInfo()
        
        infoTextView.text = viewModel.info
        view.addSubview(infoTextView)
        infoTextView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
}
