//
//  SearchTabRepository.swift
//  GitWorld
//
//  Created by Jiaxin Pu on 2024/2/28.
//

import Foundation
import Combine
import Networking

protocol SearchTabRepository {
    func requestRepositoriesList(keyWord: String, pageIndex: Int) -> AnyPublisher<[RepositoryEntity], HttpError>
}
