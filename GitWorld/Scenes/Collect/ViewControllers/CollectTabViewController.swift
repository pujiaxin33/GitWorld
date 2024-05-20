//
//  CollectTabViewController.swift
//  GitWorld
//
//  Created by Jiaxin Pu on 2024/3/19.
//

import UIKit
import Platform
import Combine
import SnapKit
import SwiftUI

class CollectTabViewController: UIHostingController<CollectTabPageView> {
    let viewModel: CollectTabViewModel
    
    init(viewModel: CollectTabViewModel) {
        self.viewModel = viewModel
        super.init(rootView: CollectTabPageView(viewModel: viewModel))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "收藏"
        viewModel.loadData()
    }
}
