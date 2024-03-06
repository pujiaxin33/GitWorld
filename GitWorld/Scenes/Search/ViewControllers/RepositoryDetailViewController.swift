//
//  RepositoryDetailViewController.swift
//  GitWorld
//
//  Created by Jiaxin Pu on 2024/3/6.
//

import UIKit
import WebKit

class RepositoryDetailViewController: UIViewController {
    private let viewModel: RepositoryDetailViewModel
    lazy var webview: WKWebView = {
        let config = WKWebViewConfiguration()
        let webview = WKWebView(frame: .zero, configuration: config)
        return webview
    }()
    
    init(viewModel: RepositoryDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = viewModel.repositoryEntity.full_name
        view.addSubview(webview)
        webview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        if let url = URL(string: viewModel.repositoryEntity.html_url ?? "") {
            let request = URLRequest(url: url)
            webview.load(request)
        }
    }
    
}
