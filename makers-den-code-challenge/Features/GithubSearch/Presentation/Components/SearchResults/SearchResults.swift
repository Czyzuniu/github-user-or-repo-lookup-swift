//
//  Paragraph.swift
//  makers-den-code-challenge
//
//  Created by Konrad Kolpak on 17/04/2026.
//

import Foundation
import SwiftUI

struct SearchResults: View {
    var status: LoadStatus

    @ViewBuilder
    var body: some View {
        ZStack {
            switch status {
            case .loading:
                ProgressView()
                    .scaleEffect(2)

            case .success(let items):
                ScrollView {
                    BodyText(text: "displaying \(items.count) items", size: .caption2)

                    LazyVStack(alignment: .leading) {
                        ForEach(items, id: \.id) { item in
                            ListItem(item: item)
                        }
                    }
                }

            case .error(let message):
                BodyText(text: message, size: .body, colour: .red)

            case .idle:
                EmptyView()
            case .noresults:
                BodyText(text: "No results found", size: .body)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
