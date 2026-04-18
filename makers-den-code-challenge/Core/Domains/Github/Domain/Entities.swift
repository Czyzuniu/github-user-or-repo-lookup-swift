//
//  Menu.swift
//  makers-den-code-challenge
//
//  Created by Konrad Kolpak on 17/04/2026.
//

import Foundation

struct GithubRepo {
    let id: Int
    let repoName: String
}

struct GithubUser {
    let id: Int
    let profileName: String
}

struct GitHubSearchResult {
    let id: Int
    let name: String
    let variant: GithubVariant
}

enum GithubVariant {
    case repository
    case user
}
