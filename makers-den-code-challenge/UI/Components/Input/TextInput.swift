import Foundation
import SwiftUI

struct TextInput: View {
    @Binding var text: String

    var onChange: ((String) -> Void)? = nil

    var placeholder: String
    var label: String
    var testId: String

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
                .accessibilityIdentifier(testId)

            if let errorMessage {
                Text(errorMessage)
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
        .padding()
    }
}
