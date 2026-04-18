//
//  Paragraph.swift
//  makers-den-code-challenge
//
//  Created by Konrad Kolpak on 17/04/2026.
//

import Foundation
import SwiftUI

struct ListItem: View {
    let item: GitHubSearchResult
    
    @ViewBuilder
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.XS.rawValue) {

            BodyText(text: item.name, size: .body)

            BodyText(
                text: item.variant == .repository ? "Repository" : "User",
                size: .caption,
                colour: .secondary
            )
            .foregroundColor(.secondary)
        }
        .padding(Spacing.XS.rawValue)
    }
}
