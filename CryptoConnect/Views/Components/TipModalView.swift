//
//  TipModalView.swift
//  CryptoConnect
//
//  Created by Melissa Zellhuber on 06/09/23.
//

import SwiftUI
import BigInt
import Web3Core
import web3swift

struct TipModalView: View {
    @StateObject private var web3Manager = Web3Manager()
    @State private var tipAmount: String = ""
    @State private var transactionResult: String?
    @State private var showingAlert = false
    
    var receiverAddress: EthereumAddress // The Ethereum address of the post creator

    var body: some View {
        VStack {
            Text("Tip Amount")
                .font(.headline)
            
            TextField("Enter amount", text: $tipAmount)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .keyboardType(.decimalPad)
                .padding()
            
            Button(action: {
                tipButtonPressed()
            }) {
                HStack {
                    Image(systemName: "gift")
                        .resizable()
                        .frame(width: 24, height: 24)
                    Text("Send Tip")
                        .font(.headline)
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Transaction Result"), message: Text(transactionResult ?? "Unknown error"), dismissButton: .default(Text("OK")))
            }
        }
        .padding()
    }

    func tipButtonPressed() {
        Task {
            do {
                guard let value = BigUInt(tipAmount) else {
                    transactionResult = "Invalid tip amount"
                    showingAlert = true
                    return
                }
                
                var transaction = CodableTransaction(to: receiverAddress)
                transaction.value = value
                
                let gasPrice = try await web3Manager.getGasPrice()
                let gasLimit = try await web3Manager.estimateGas(transaction: transaction)
                
                let result = try await web3Manager.sendTransaction(to: receiverAddress, value: value, gasPrice: gasPrice, gasLimit: gasLimit)
                transactionResult = "Transaction successful: \(result)"
            } catch {
                transactionResult = "Transaction failed: \(error)"
            }
            showingAlert = true
        }
    }
}
