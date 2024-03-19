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
import ESPullToRefresh
import RxDataSources

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
    private var loadMoreSubject: PublishSubject<Void> = .init()
    
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        searchBar.isActive = false
    }
    
    private func setupViews() {
        self.title = "搜索"
        
        searchBar.searchResultsUpdater = self
        navigationItem.searchController = searchBar
        setupTableView()
        view.addSubview(tableView)
        self.tableView.es.addInfiniteScrolling {
            [unowned self] in
            self.loadMoreSubject.onNext(())
        }
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupBindings() {
        let searchRepositoryDriver = searchResultSubject
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .do(onNext: { _ in
                LoadingView.show()
            })
            .asDriver(onErrorJustReturn: "")
        let loadMoreRepository = loadMoreSubject.do(onNext: { _ in
            LoadingView.show()
        }).asDriver(onErrorJustReturn: ())
        let input = SearchTabViewModel.Input(searchRepository: searchRepositoryDriver, loadMoreRepository: loadMoreRepository)
        
        let output = viewModel.transform(input)
        output.cellModels.drive { [weak self] result in
            LoadingView.hide()
            switch result {
            case .success:
                self?.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }.disposed(by: bags)
        
//        let dataSource = RxTableViewSectionedReloadDataSource<SearchRepositoryListSecionModel>(
//          configureCell: {[weak self] dataSource, tableView, indexPath, item in
//              let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryCell.reuseIdentifier, for: indexPath) as! RepositoryCell
//              cell.updateUI(item.entity)
//              cell.clickCollectButtonCallback = { [weak self] in
//                  self?.viewModel.collectRepository(item.entity)
//              }
//            return cell
//        })
//        output.updatedRepositories
//            .asObservable()
//            .bind(to: tableView.rx.items(dataSource: dataSource))
//            .disposed(by: bags)
        
    }
}

extension SearchTabViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text, !query.isEmpty else { return }
        searchResultSubject.onNext(query)
    }
}
