import Foundation
import SwiftUI

struct SearchInput: View {
    @Binding var text: String
    let onChange: (String) -> Void

    fileprivate func handleErrorMessage() -> String? {
        if (text.isEmpty) {
            return nil;
        }
        
        return text.count < 3 ? "Please enter at least 3 characters to begin search" : nil
    }
    
    var body: some View {
        TextInput(
            text: $text,
            placeholder: "Search...",
            label: "Search for GitHub Users or Repositories",
            errorMessage: handleErrorMessage()
        )
        .onChange(of: text) { _, newValue in
            onChange(newValue)
        }
    }
}
