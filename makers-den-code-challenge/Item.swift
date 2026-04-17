//
//  Item.swift
//  makers-den-code-challenge
//
//  Created by Konrad Kolpak on 17/04/2026.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
