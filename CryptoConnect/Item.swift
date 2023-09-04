//
//  Item.swift
//  CryptoConnect
//
//  Created by Melissa Zellhuber on 04/09/23.
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
