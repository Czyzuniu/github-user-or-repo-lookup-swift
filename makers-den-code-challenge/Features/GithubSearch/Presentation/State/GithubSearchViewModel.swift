import Foundation

import Combine
import SwiftUI

class GithubSearchViewModel: ObservableObject {
    @Published var state: GithubSearchState
    private var service: GithubSearchService
    private var debounceTask: Task<Void, Never>?
    var debounceDuration: UInt64 = Constants.DEFAULT_SEARCH_DEBOUNCE


    init(state: GithubSearchState, service: GithubSearchService) {
        self.state = state
        self.service = service
    }
    
    init(state: GithubSearchState, service: GithubSearchService, debounceDuration: UInt64) {
        self.state = state
        self.service = service
        self.debounceDuration = debounceDuration
    }

    func onSearchInputChanged(_ value: String) {
        state.searchQuery = value

        debounceTask?.cancel()

        if value.count < 3 {
            state.status = .idle
            return
        }

        debounceTask = Task {
            try? await Task.sleep(nanoseconds: self.debounceDuration)

            guard !Task.isCancelled else { return }

            state.status = .loading

            do {
                let results = try await service.search(query: value)

                state.status = results.isEmpty
                    ? .noresults
                    : .success(results)

            } catch is CancellationError {
            } catch let error as GitHubRepositoryError {
                switch error {
                case .genericResponse(let message):
                    state.status = .error(message)
                }
            } catch {
                state.status = .error(error.localizedDescription)
            }
        }
    }
}
