//
//  ContentView.swift
//  makers-den-code-challenge
//
//  Created by Konrad Kolpak on 17/04/2026.
//

import SwiftUI 
import SwiftData

struct ContentView: View {
    var body: some View {
        GithubSearchPage().environmentObject(GithubSearchViewModel(
            state: GithubSearchState(),
            service: GithubSearchService(repository: GithubRepositoryImpl(githubApi: GitHubApiImpl()))
        ))
    }
}

#Preview {
    ContentView()
}
