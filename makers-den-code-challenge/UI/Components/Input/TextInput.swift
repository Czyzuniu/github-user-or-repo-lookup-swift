//
//  Paragraph.swift
//  makers-den-code-challenge
//
//  Created by Konrad Kolpak on 17/04/2026.
//

import Foundation
import SwiftUI

struct TextInput: View {
    @Binding var text: String

    var onChange: ((String) -> Void)? = nil

    var placeholder: String
    var label: String

    var errorMessage: String? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {

            Text(label)
                .font(.caption)
                .foregroundColor(.primary)

            TextField(placeholder, text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onChange(of: text) { _, newValue in
                    onChange?(newValue)
                }

            if let errorMessage {
                Text(errorMessage)
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
        .padding()
    }
}
