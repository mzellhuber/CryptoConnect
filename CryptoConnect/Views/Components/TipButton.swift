//
//  TipButton.swift
//  CryptoConnect
//
//  Created by Melissa Zellhuber on 06/09/23.
//

import SwiftUI
import Web3Core

struct TipButton: View {
    @State private var isTipModalPresented: Bool = false
    @State private var tipAmount: String = ""
    var post: Post
    @ObservedObject var web3Manager: Web3Manager

    var body: some View {
        Button(action: {
            isTipModalPresented.toggle()
        }) {
            HStack {
                Image(systemName: "gift")
                Text("Tip")
            }
            .padding()
            .background(ColorPalette.buttonBackground)
            .cornerRadius(8)
        }
        .sheet(isPresented: $isTipModalPresented) {
            if let receiverAddress = EthereumAddress(post.owner.walletAddress) {
                TipModalView(receiverAddress: receiverAddress)
            } else {
                // Handle invalid address error
            }
        }
    }
}
