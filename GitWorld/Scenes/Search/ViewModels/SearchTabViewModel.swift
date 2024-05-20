//
//  SearchMainViewModel.swift
//  GitWorld
//
//  Created by Jiaxin Pu on 2024/1/30.
//

import Foundation
import Platform
import Networking
import Combine

class SearchTabViewModel: ObservableObject {
    
    enum Action {
        case search(String)
        case loadMore
    }
    @Published var cellModels: [RepositoryCellModel] = []
    @Published var searchText: String = ""
    @Published var hasMoreData: Bool = true
    
    private let searchSubject: PassthroughSubject<String, Never> = .init()
    private var bags: Set<AnyCancellable> = .init()
    private let useCase: SearchTabUseCase
    private let navigator: SearchTabNavigator
    private var currentPageIndex: Int = 1
    private var currentKeyword: String?
    
    init(useCase: SearchTabUseCase, navigator: SearchTabNavigator) {
        self.useCase = useCase
        self.navigator = navigator
        
        setupBinding()
    }
    
    func sendAction(_ action: Action) {
        switch action {
        case .search(let string):
            searchSubject.send(string)
        case .loadMore:
            break
        }
    }
    
    private func setupBinding() {
        searchSubject.debounce(for: .seconds(0.25), scheduler: RunLoop.main).sink {[weak self] text in
            self?.startSearch(text)
        }.store(in: &bags)
    }
    
    func pushToRepositoryDetail(_ model: RepositoryEntity) {
        navigator.pushToRepositoryDetail(model)
    }
    
    func collectRepository(_ entity: RepositoryEntity) {
        useCase.collectRepository(entity)
        cellModels.first { $0.entity.id == entity.id }?.isCollected = true
        self.cellModels = cellModels
    }
    
    func uncollectRepository(_ entity: RepositoryEntity) {
        useCase.uncollectRepository(entity)
        cellModels.first { $0.entity.id == entity.id }?.isCollected = false
        self.cellModels = cellModels
    }
    
    func loadMore() {
        guard let currentKeyword else { return }
        currentPageIndex += 1
        self.useCase.requestRepositoriesList(keyWord: currentKeyword, pageIndex: currentPageIndex).sink { completion in
            switch completion {
            case .finished:
                break;
            case .failure:
                break
            }
        } receiveValue: { entities in
            self.hasMoreData = entities.count < CommonDefines.pageSize
            let collected = self.useCase.getCollectedRepositoriesList().map { $0.id ?? 0}
            let newCellModels = entities.map { entity in
                RepositoryCellModel(entity: entity, isCollected: collected.contains(entity.id ?? 0))
            }
            self.cellModels.append(contentsOf: newCellModels)
        }.store(in: &bags)
    }
    
    private func startSearch(_ text: String) {
        currentKeyword = text
        currentPageIndex = 1
        self.useCase.requestRepositoriesList(keyWord: text, pageIndex: currentPageIndex).sink { completion in
            switch completion {
            case .finished:
                break;
            case .failure:
                break
            }
        } receiveValue: { entities in
            let collected = self.useCase.getCollectedRepositoriesList().map { $0.id ?? 0}
            self.hasMoreData = entities.count < CommonDefines.pageSize
            self.cellModels = entities.map { entity in
                RepositoryCellModel(entity: entity, isCollected: collected.contains(entity.id ?? 0))
            }
        }.store(in: &bags)
    }
}
