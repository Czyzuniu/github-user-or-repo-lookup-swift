import Foundation
import SwiftUI

struct SearchPanel: View {
    @ObservedObject var viewModel: GithubSearchViewModel

    var body: some View {
        VStack {
            SearchInput(text: $viewModel.state.searchQuery, onChange: viewModel.onSearchInputChanged)
            SearchResults(status: viewModel.state.status)
        }.padding(Spacing.SM.rawValue)
    }
}
