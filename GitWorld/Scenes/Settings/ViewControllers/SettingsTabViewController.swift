//
//  SettingsTabViewController.swift
//  GitWorld
//
//  Created by Jiaxin Pu on 2024/4/17.
//

import UIKit
import Platform
import Combine
import SwiftUI

class SettingsTabViewController: UIHostingController<SettingsTabPageView> {
    let viewModel: SettingsTabViewModel
    
    init(viewModel: SettingsTabViewModel) {
        self.viewModel = viewModel
        super.init(rootView: SettingsTabPageView(viewModel: viewModel))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "设置"
        viewModel.loadData()
    }
}
