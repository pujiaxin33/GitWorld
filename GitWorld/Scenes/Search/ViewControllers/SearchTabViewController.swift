//
//  SearchMainViewController.swift
//  GitWorld
//
//  Created by Jiaxin Pu on 2024/1/30.
//

import UIKit
import Platform
import Combine
import SnapKit
import ESPullToRefresh
import SwiftUI

class SearchTabViewController: UIHostingController<SearchTabPageView> {
    let viewModel: SearchTabViewModel
    
    init(viewModel: SearchTabViewModel) {
        self.viewModel = viewModel
        super.init(rootView: SearchTabPageView(viewModel: viewModel))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "搜索"
    }
    
}

