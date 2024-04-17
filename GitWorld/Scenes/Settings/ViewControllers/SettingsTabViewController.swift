//
//  SettingsTabViewController.swift
//  GitWorld
//
//  Created by Jiaxin Pu on 2024/4/17.
//

import UIKit
import Platform
import RxCocoa
import RxSwift

class SettingsTabViewController: BaseViewController {
    let viewModel: SettingsTabViewModel
    private let initCellModelsSubject: PublishSubject<Void> = .init()
    private var bags: DisposeBag = .init()
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        return tableView
    }()
    
    init(viewModel: SettingsTabViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "设置"
        setupTableView()
        setupBindings()
        
        initCellModelsSubject.onNext(())
    }
    
    private func setupBindings() {
        let input = SettingsTabViewModel.Input(refreshCellModels: initCellModelsSubject.asDriver(onErrorJustReturn: ()))
        let output = viewModel.transform(input)
        output.cellModels.drive {[weak self] _ in
            self?.tableView.reloadData()
        }.disposed(by: bags)
    }
}

extension SettingsTabViewController {
    private var cellModels: [SettingsTabCellModel] {
        self.viewModel.cellModels
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingsTabSettingsItemCell.self, forCellReuseIdentifier: SettingsTabSettingsItemCell.reuseIdentifier)
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension SettingsTabViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellModel = cellModels[indexPath.row]
        switch cellModel.cellType {
        case .about:
            viewModel.pushToAboutPage()
        }
    }
}

extension SettingsTabViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTabSettingsItemCell.reuseIdentifier, for: indexPath) as! SettingsTabSettingsItemCell
        let cellModel = cellModels[indexPath.row]
        cell.updateUI(cellModel)
        return cell
    }
}
