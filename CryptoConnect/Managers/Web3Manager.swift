//
//  Web3Manager.swift
//  CryptoConnect
//
//  Created by Melissa Zellhuber on 06/09/23.
//

import Foundation
import web3swift
import BigInt
import Web3Core

class Web3Manager {

    let web3: Web3

    init(provider: Web3Provider) {
        self.web3 = Web3(provider: provider)
    }

    func createWallet(password: String) async throws -> EthereumKeystoreV3 {
        let keystore = try EthereumKeystoreV3(password: password)!
        let keystoreManager = KeystoreManager([keystore])
        web3.addKeystoreManager(keystoreManager)
        return keystore
    }

    func importWallet(privateKey: String, password: String) async throws -> EthereumKeystoreV3 {
        let dataKey = Data(hex: privateKey)
        let keystore = try EthereumKeystoreV3(privateKey: dataKey, password: password)!
        let keystoreManager = KeystoreManager([keystore])
        web3.addKeystoreManager(keystoreManager)
        return keystore
    }

    func getBalance(address: EthereumAddress) async throws -> BigUInt {
        let balance = try await web3.eth.getBalance(for: address, onBlock: .latest)
        return balance
    }

    func sendTransaction(to: EthereumAddress, value: BigUInt, gasPrice: BigUInt, gasLimit: BigUInt) async throws -> TransactionSendingResult {
        var transaction = CodableTransaction(to: to)
        transaction.value = value
        transaction.gasPrice = gasPrice
        transaction.gasLimit = gasLimit

        let sendingResult = try await web3.eth.send(transaction)
        return sendingResult
    }

    func getTransactionDetails(txHash: Data) async throws -> TransactionDetails {
        let transactionDetails = try await web3.eth.transactionDetails(txHash)
        return transactionDetails
    }
}
