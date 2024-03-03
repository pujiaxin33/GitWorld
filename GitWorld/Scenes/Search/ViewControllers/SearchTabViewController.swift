//
//  SearchMainViewController.swift
//  GitWorld
//
//  Created by Jiaxin Pu on 2024/1/30.
//

import UIKit
import Platform
import RxSwift
import SnapKit

class SearchTabViewController: BaseViewController {
    private let viewModel: SearchTabViewModel
    private var bags: DisposeBag = .init()
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("搜索", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        return tableView
    }()
    var repositoryList: [RepositoryEntity] = []
    
    init(viewModel: SearchTabViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupBindings()
    }
    
    private func setupViews() {
        self.title = "搜索"
        
        setupTableView()
        view.addSubview(tableView)
        view.addSubview(searchButton)
        
        searchButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupBindings() {
        let searchRepositoryDriver = searchButton.rx.tap.do { _ in
            LoadingView.show()
        }.map { "swift" }.asDriver(onErrorJustReturn: "")
    
        let input = SearchTabViewModel.Input(searchRepository: searchRepositoryDriver)
        let output = viewModel.transform(input)
        output.repositories.drive { [weak self] result in
            switch result {
            case .success(let items):
                LoadingView.succeed("请求成功了")
                self?.repositoryList = items
                self?.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
                LoadingView.hide()
            }
        }.disposed(by: bags)
    }
}