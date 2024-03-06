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
    let viewModel: SearchTabViewModel
    private var bags: DisposeBag = .init()
    private var searchBar: UISearchController = {
        let sb = UISearchController()
        sb.searchBar.placeholder = "Enter repository name"
        sb.searchBar.searchBarStyle = .minimal
        return sb
    }()
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        return tableView
    }()
    private var searchResultSubject: PublishSubject<String> = .init()
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
        
        searchBar.searchResultsUpdater = self
        navigationItem.searchController = searchBar
        setupTableView()
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupBindings() {
        let searchRepositoryDriver = searchResultSubject
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .asDriver(onErrorJustReturn: "")
    
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

extension SearchTabViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text, !query.isEmpty else { return }
        searchResultSubject.onNext(query)
    }
}
