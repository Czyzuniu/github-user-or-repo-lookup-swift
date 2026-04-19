import SwiftUI

struct GithubSearchPage: View {
    @StateObject private var viewModel: GithubSearchViewModel

    init() {
        _viewModel = StateObject(wrappedValue:
            GithubSearchViewModel(
                state: GithubSearchState(),
                service: GithubSearchService(
                    repository: GithubRepositoryImpl(githubApi: GitHubApiImpl())
                )
            )
        )
    }
    
    init(viewModel: GithubSearchViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        SearchPanel(viewModel: viewModel)
    }
}

#Preview("With Results") {
    GithubSearchPage(
        viewModel: GithubSearchViewModel(
            state: GithubSearchState(
                searchQuery: "sample search",
                status: .success([
                    GitHubSearchResult(id: 1, name: "Repository", variant: .repository),
                    GitHubSearchResult(id: 2, name: "User", variant: .user)
                ])
            ),
            service: GithubSearchService(
                repository: GithubRepositoryImpl(githubApi: GitHubApiImpl())
            )
        )
    )
}

#Preview("Loading") {
    GithubSearchPage(
        viewModel: GithubSearchViewModel(
            state: GithubSearchState(
                searchQuery: "sample search",
                status: .loading
            ),
            service: GithubSearchService(
                repository: GithubRepositoryImpl(githubApi: GitHubApiImpl())
            )
        )
    )
}

#Preview("No Results") {
    GithubSearchPage(
        viewModel: GithubSearchViewModel(
            state: GithubSearchState(
                searchQuery: "sample search",
                status: .noresults
            ),
            service: GithubSearchService(
                repository: GithubRepositoryImpl(githubApi: GitHubApiImpl())
            )
        )
    )
}

#Preview("With error") {
    GithubSearchPage(
        viewModel: GithubSearchViewModel(
            state: GithubSearchState(
                searchQuery: "sample search",
                status: .error("There was a problem")
            ),
            service: GithubSearchService(
                repository: GithubRepositoryImpl(githubApi: GitHubApiImpl())
            )
        )
    )
}
