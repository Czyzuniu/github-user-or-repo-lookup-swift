//
//  Models.swift
//  makers-den-code-challenge
//
//  Created by Konrad Kolpak on 17/04/2026.
//

import Foundation

struct GithubSearchUsersResponse: Decodable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [GithubUserModel]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}

struct GithubUserModel: Decodable {
    let login: String
    let id: Int
    let nodeId: String
    let avatarUrl: String
    let gravatarId: String
    let url: String
    let htmlUrl: String
    let followersUrl: String
    let followingUrl: String
    let gistsUrl: String
    let starredUrl: String
    let subscriptionsUrl: String
    let organizationsUrl: String
    let reposUrl: String
    let eventsUrl: String
    let receivedEventsUrl: String
    let type: String
    let siteAdmin: Bool

    enum CodingKeys: String, CodingKey {
        case login
        case id
        case nodeId = "node_id"
        case avatarUrl = "avatar_url"
        case gravatarId = "gravatar_id"
        case url
        case htmlUrl = "html_url"
        case followersUrl = "followers_url"
        case followingUrl = "following_url"
        case gistsUrl = "gists_url"
        case starredUrl = "starred_url"
        case subscriptionsUrl = "subscriptions_url"
        case organizationsUrl = "organizations_url"
        case reposUrl = "repos_url"
        case eventsUrl = "events_url"
        case receivedEventsUrl = "received_events_url"
        case type
        case siteAdmin = "site_admin"
    }
}

struct GithubSearchReposResponse: Decodable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [GithubRepoModel]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}

struct GithubRepoModel : Decodable {
    let id: Int
    let name: String
    let fullName: String
    let isPrivate: Bool
    let owner: GithubRepoOwner
    let htmlUrl: String
    let description: String?
    let isFork: Bool
    let url: String
    let stargazersCount: Int
    let watchersCount: Int
    let language: String?

    enum CodingKeys: String, CodingKey {
        case id, name, owner, description, url, language
        case fullName = "full_name"
        case isPrivate = "private"
        case htmlUrl = "html_url"
        case isFork = "fork"
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
    }
}

struct GithubRepoOwner: Decodable {
    let login: String
    let id: Int
    let avatarUrl: String

    enum CodingKeys: String, CodingKey {
        case login, id
        case avatarUrl = "avatar_url"
    }
}
