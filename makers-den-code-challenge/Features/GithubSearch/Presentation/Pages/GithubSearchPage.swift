//
//  LoginPage.swift
//  makers-den-code-challenge
//
//   Created by Konrad Kolpak on 17/04/2026.
//

import SwiftUI

struct GithubSearchPage: View {
    @EnvironmentObject var viewModel: GithubSearchViewModel
    
    var body: some View {
        VStack {
            SearchInput(text: $viewModel.state.searchQuery, onChange: viewModel.onSearchInputChanged)
            SearchResults(status: viewModel.state.status)
        }.padding(Spacing.SM.rawValue)
    }

}

#Preview("With Results") {
    GithubSearchPage().environmentObject(GithubSearchViewModel(
        state: GithubSearchState(searchQuery: "sample search", status: LoadStatus.success([
            GitHubSearchResult(id: 1, name: "Repository", variant: GithubVariant.repository),
             GitHubSearchResult(id: 2, name: "User", variant: GithubVariant.user)]
        )),
        service: GithubSearchService(repository: GithubRepositoryImpl(githubApi: GitHubApiImpl())))
    )
}

#Preview("Loading") {
    GithubSearchPage().environmentObject(GithubSearchViewModel(
        state: GithubSearchState(searchQuery: "sample search", status: LoadStatus.loading),
        service: GithubSearchService(repository: GithubRepositoryImpl(githubApi: GitHubApiImpl())))
    )
}

#Preview("No Results") {
    GithubSearchPage().environmentObject(GithubSearchViewModel(
        state: GithubSearchState(searchQuery: "sample search", status: LoadStatus.noresults),
        service: GithubSearchService(repository: GithubRepositoryImpl(githubApi: GitHubApiImpl())))
    )
}

#Preview("With error") {
    GithubSearchPage().environmentObject(GithubSearchViewModel(
        state: GithubSearchState(searchQuery: "sample search", status: LoadStatus.error("There was a problem")),
        service: GithubSearchService(repository: GithubRepositoryImpl(githubApi: GitHubApiImpl())))
    )
}
