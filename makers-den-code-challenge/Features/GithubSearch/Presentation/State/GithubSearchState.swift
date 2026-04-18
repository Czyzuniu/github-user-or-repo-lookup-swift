//
//  AuthState.swift
//  makers-den-code-challenge
//
//  Created by Konrad Kolpak on 17/04/2026.
//

import Foundation

struct GithubSearchState {
    var searchQuery: String
    var status: LoadStatus

    init() {
        searchQuery = ""
        status = LoadStatus.idle
    }
    
    init(searchQuery: String, status: LoadStatus) {
        self.searchQuery = searchQuery
        self.status = status
    }
}

enum LoadStatus {
    case idle
    case loading
    case success([GitHubSearchResult])
    case noresults
    case error(String)
}
