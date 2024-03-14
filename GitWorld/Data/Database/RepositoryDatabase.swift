//
//  RepositoryDatabase.swift
//  GitWorld
//
//  Created by Jiaxin Pu on 2024/3/6.
//

import Foundation
import SQLite

protocol RepositoryDatabase {
    func createTable() throws
    func save(_ entity: RepositoryEntity) throws
    func delete(_ entity: RepositoryEntity) throws
    func queryAll() -> [RepositoryEntity]
}

class StandardRepositoryDatabase: RepositoryDatabase {
    private let connection: Connection?
    private let repositoriesTable = Table("repositories")
    private let id = Expression<Int>("id")
    private let full_name = Expression<String?>("full_name")
    private let html_url = Expression<String?>("html_url")
    private let description = Expression<String?>("description")
    private let stargazers_count = Expression<Int?>("stargazers_count")
    private let avatar_url = Expression<String?>("avatar_url")
    
    init() {
        self.connection = try? Connection("./sqliteFiles/repositories.sqlite3")
    }
    
    func createTable() throws {
        try connection?.run(repositoriesTable.create { t in
            t.column(id, primaryKey: true)
            t.column(full_name)
            t.column(html_url, unique: true)
            t.column(description)
            t.column(stargazers_count)
        })
    }
    
    func save(_ entity: RepositoryEntity) throws {
        let insert = repositoriesTable.insert(
            id <- entity.id ?? 0,
            full_name <- entity.full_name,
            html_url <- entity.html_url,
            description <- entity.description,
            stargazers_count <- entity.stargazers_count,
            avatar_url <- entity.owner?.avatar_url
        )
        try connection?.run(insert)
    }
    
    func delete(_ entity: RepositoryEntity) throws {
        let target = repositoriesTable.filter(id == entity.id ?? 0)
        try connection?.run(target.delete())
    }
    
    func queryAll() -> [RepositoryEntity] {
        guard let items = try? connection?.prepare(repositoriesTable) else {
            return []
        }
        var result: [RepositoryEntity] = .init()
        for item in items {
            let entity = RepositoryEntity(
                id: item[id],
                full_name: item[full_name], 
                owner: RepositoryOwner(avatar_url: item[avatar_url]),
                html_url: item[html_url],
                description: item[description],
                stargazers_count: item[stargazers_count]
            )
            result.append(entity)
        }
        return result
    }
}
