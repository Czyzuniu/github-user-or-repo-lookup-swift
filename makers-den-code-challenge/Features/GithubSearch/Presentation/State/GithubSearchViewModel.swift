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
        debounceTask?.cancel()
        state.searchQuery = value

        if value.count < 3 {
            state.status = .idle
            return
        }
        

        debounceTask = Task {
            do {
                try await Task.sleep(nanoseconds: self.debounceDuration)

                guard !Task.isCancelled else { return }

                state.status = .loading
                let results = try await service.search(query: value)

                state.status = results.isEmpty
                    ? .noresults
                    : .success(results)

            } catch is CancellationError {
            } catch let error as GithubSearchError {
                switch error {
                case .serverError:
                    state.status = .error("Something went wrong, please try again")
                case .rateLimit:
                    state.status = .error("Too many requests. Please pause for a few seconds before your next search.")
                }
            } catch {
                state.status = .error(error.localizedDescription)
            }
        }
    }
}
