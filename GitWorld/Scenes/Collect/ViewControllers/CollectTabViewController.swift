//
//  CollectTabViewController.swift
//  GitWorld
//
//  Created by Jiaxin Pu on 2024/3/19.
//

import UIKit
import Platform
import RxSwift
import SnapKit
import ESPullToRefresh

class CollectTabViewController: BaseViewController {
    let viewModel: CollectTabViewModel
    private var bags: DisposeBag = .init()
    private let getRepositoryListSubject: PublishSubject<Void> = .init()
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        return tableView
    }()
    
    init(viewModel: CollectTabViewModel) {
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
        
        getRepositoryListSubject.onNext(())
    }

    private func setupViews() {
        self.title = "收藏"
        
        setupTableView()
        view.addSubview(tableView)
        tableView.es.addPullToRefresh { [weak self] in
            self?.getRepositoryListSubject.onNext(())
        }
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupBindings() {
        
        let getRepositoryListDriver = getRepositoryListSubject.do(onNext: { _ in
            LoadingView.show()
        }).asDriver(onErrorJustReturn: ())
        let input = CollectTabViewModel.Input(queryAllRepositories: getRepositoryListDriver)
        let output = viewModel.transform(input)
        
        output.cellModels.drive { [weak self] result in
            LoadingView.hide()
            self?.tableView.es.stopPullToRefresh()
            switch result {
            case .success:
                self?.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }.disposed(by: bags)
    }
}
