import Foundation
import SwiftUI

struct BodyText: View {
    let text: String
    let size: Font
    let colour: Color?

    init(text: String, size: Font, colour: Color?) {
        self.text = text
        self.size = size
        self.colour = colour
    }

    init(text: String, size: Font) {
        self.text = text
        self.size = size
        colour = nil
    }

    @ViewBuilder
    var body: some View {
        Text(text)
            .font(size)
            .foregroundColor(colour)
    }
}
