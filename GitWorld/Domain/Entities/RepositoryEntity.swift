//
//  RepositoryEntity.swift
//  GitWorld
//
//  Created by Jiaxin Pu on 2024/1/30.
//

import Foundation

struct RepositoryResult: Codable {
    let total_count: Int?

    let incomplete_results: Bool?

    let items: [RepositoryEntity]?
}

struct RepositoryOwner: Codable {
    let login: String?

    let id: Int?

    let node_id: String?

    let avatar_url: String?

    let gravatar_id: String?

    let url: String?

    let received_events_url: String?

    let type: String?

    let html_url: String?

    let followers_url: String?

    let following_url: String?

    let gists_url: String?

    let starred_url: String?

    let subscriptions_url: String?

    let organizations_url: String?

    let repos_url: String?

    let events_url: String?

    let site_admin: Bool?
    
    init(avatar_url: String?) {
        self.login = nil
        self.id = nil
        self.node_id = nil
        self.avatar_url = avatar_url
        self.gravatar_id = nil
        self.url = nil
        self.received_events_url = nil
        self.type = nil
        self.html_url = nil
        self.followers_url = nil
        self.following_url = nil
        self.gists_url = nil
        self.starred_url = nil
        self.subscriptions_url = nil
        self.organizations_url = nil
        self.repos_url = nil
        self.events_url = nil
        self.site_admin = nil
    }
}


struct RepositoryLicense: Codable {
    let key: String?

    let name: String?

    let url: String?

    let spdx_id: String?

    let node_id: String?

    let html_url: String??

}

struct RepositoryEntity: Codable {
    let id: Int?

    let node_id: String?

    let name: String?

    let full_name: String?

    let owner: RepositoryOwner?

    let html_url: String?

    let description: String?

    let fork: Bool?

    let url: String?

    let created_at: String?

    let updated_at: String?

    let pushed_at: String?

    let homepage: String?

    let size: Int?

    let stargazers_count: Int?

    let watchers_count: Int?

    let language: String?

    let forks_count: Int?

    let open_issues_count: Int?

    let default_branch: String?

    let score: Int?

    let archive_url: String?

    let assignees_url: String?

    let blobs_url: String?

    let branches_url: String?

    let collaborators_url: String?

    let comments_url: String?

    let commits_url: String?

    let compare_url: String?

    let contents_url: String?

    let contributors_url: String?

    let deployments_url: String?

    let downloads_url: String?

    let events_url: String?

    let forks_url: String?

    let git_commits_url: String?

    let git_refs_url: String?

    let git_tags_url: String?

    let git_url: String?

    let issue_comment_url: String?

    let issue_events_url: String?

    let issues_url: String?

    let keys_url: String?

    let labels_url: String?

    let languages_url: String?

    let merges_url: String?

    let milestones_url: String?

    let notifications_url: String?

    let pulls_url: String?

    let releases_url: String?

    let ssh_url: String?

    let stargazers_url: String?

    let statuses_url: String?

    let subscribers_url: String?

    let subscription_url: String?

    let tags_url: String?

    let teams_url: String?

    let trees_url: String?

    let clone_url: String?

    let mirror_url: String??

    let hooks_url: String?

    let svn_url: String?

    let forks: Int?

    let open_issues: Int?

    let watchers: Int?

    let has_issues: Bool?

    let has_projects: Bool?

    let has_pages: Bool?

    let has_wiki: Bool?

    let has_downloads: Bool?

    let archived: Bool?

    let disabled: Bool?

    let visibility: String?

    let license: RepositoryLicense?
    
    init(id: Int?, full_name: String?, owner: RepositoryOwner?, html_url: String?, description: String?, stargazers_count: Int?) {
        self.id = id
        self.node_id = nil
        self.name = nil
        self.full_name = full_name
        self.owner = owner
        self.html_url = html_url
        self.description = description
        self.fork = nil
        self.url = nil
        self.created_at = nil
        self.updated_at = nil
        self.pushed_at = nil
        self.homepage = nil
        self.size = nil
        self.stargazers_count = stargazers_count
        self.watchers_count = nil
        self.language = nil
        self.forks_count = nil
        self.open_issues_count = nil
        self.default_branch = nil
        self.score = nil
        self.archive_url = nil
        self.assignees_url = nil
        self.blobs_url = nil
        self.branches_url = nil
        self.collaborators_url = nil
        self.comments_url = nil
        self.commits_url = nil
        self.compare_url = nil
        self.contents_url = nil
        self.contributors_url = nil
        self.deployments_url = nil
        self.downloads_url = nil
        self.events_url = nil
        self.forks_url = nil
        self.git_commits_url = nil
        self.git_refs_url = nil
        self.git_tags_url = nil
        self.git_url = nil
        self.issue_comment_url = nil
        self.issue_events_url = nil
        self.issues_url = nil
        self.keys_url = nil
        self.labels_url = nil
        self.languages_url = nil
        self.merges_url = nil
        self.milestones_url = nil
        self.notifications_url = nil
        self.pulls_url = nil
        self.releases_url = nil
        self.ssh_url = nil
        self.stargazers_url = nil
        self.statuses_url = nil
        self.subscribers_url = nil
        self.subscription_url = nil
        self.tags_url = nil
        self.teams_url = nil
        self.trees_url = nil
        self.clone_url = nil
        self.mirror_url = nil
        self.hooks_url = nil
        self.svn_url = nil
        self.forks = nil
        self.open_issues = nil
        self.watchers = nil
        self.has_issues = nil
        self.has_projects = nil
        self.has_pages = nil
        self.has_wiki = nil
        self.has_downloads = nil
        self.archived = nil
        self.disabled = nil
        self.visibility = nil
        self.license = nil
    }
}
