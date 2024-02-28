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
//        button.addTarget(self, action: #selector(onClickSearchButton), for: .touchUpInside)
        return button
    }()
    
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
        self.title = "搜索🔍"
        
        view.addSubview(searchButton)
        searchButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func setupBindings() {
        let searchRepositoryDriver = searchButton.rx.tap.do { _ in
            print("show loading")
        }.map { "swift" }.asDriver(onErrorJustReturn: "")
    
        let input = SearchTabViewModel.Input(searchRepository: searchRepositoryDriver)
        let output = viewModel.transform(input)
        output.repositories.drive { [weak self] result in
            switch result {
            case .success(_):
                print("成功了")
            case .failure(let error):
                print("error")
            }
        }.disposed(by: bags)
    }
}
