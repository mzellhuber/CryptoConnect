//
//  CryptoConnectApp.swift
//  CryptoConnect
//
//  Created by Melissa Zellhuber on 04/09/23.
//

import SwiftUI
import SwiftData

@main
struct CryptoConnectApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Item.self)
    }
}
