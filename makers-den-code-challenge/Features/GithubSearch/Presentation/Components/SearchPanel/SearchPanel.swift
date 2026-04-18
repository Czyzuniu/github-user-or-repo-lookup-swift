
//
//  Paragraph.swift
//  makers-den-code-challenge
//
//  Created by Konrad Kolpak on 17/04/2026.
//

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
