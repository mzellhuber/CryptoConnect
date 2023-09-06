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

enum Web3ManagerError: Error, LocalizedError {
    case invalidPrivateKey
    case invalidKeystore
    case transactionFailed
    case unableToFetchBalance
    case unableToFetchTransactionDetails

    var errorDescription: String? {
        switch self {
        case .invalidPrivateKey:
            return "The provided private key is invalid."
        case .invalidKeystore:
            return "Unable to create or import keystore."
        case .transactionFailed:
            return "Transaction failed."
        case .unableToFetchBalance:
            return "Unable to fetch balance."
        case .unableToFetchTransactionDetails:
            return "Unable to fetch transaction details."
        }
    }
}

class Web3Manager {
    let web3: Web3

    init(provider: Web3Provider) {
        self.web3 = Web3(provider: provider)
    }

    func createWallet(password: String) async throws -> EthereumKeystoreV3 {
        guard let keystore = try? EthereumKeystoreV3(password: password) else {
            throw Web3ManagerError.invalidKeystore
        }
        let keystoreManager = KeystoreManager([keystore])
        web3.addKeystoreManager(keystoreManager)
        return keystore
    }

    func importWallet(privateKey: String, password: String) async throws -> EthereumKeystoreV3 {
        let dataKey = Data(hex: privateKey)
        guard let keystore = try? EthereumKeystoreV3(privateKey: dataKey, password: password) else {
            throw Web3ManagerError.invalidPrivateKey
        }
        let keystoreManager = KeystoreManager([keystore])
        web3.addKeystoreManager(keystoreManager)
        return keystore
    }

    func getBalance(address: EthereumAddress) async throws -> BigUInt {
        do {
            let balance = try await web3.eth.getBalance(for: address, onBlock: .latest)
            return balance
        } catch {
            throw Web3ManagerError.unableToFetchBalance
        }
    }

    func sendTransaction(to: EthereumAddress, value: BigUInt, gasPrice: BigUInt, gasLimit: BigUInt) async throws -> TransactionSendingResult {
        var transaction = CodableTransaction(to: to)
        transaction.value = value
        transaction.gasPrice = gasPrice
        transaction.gasLimit = gasLimit

        do {
            let sendingResult = try await web3.eth.send(transaction)
            return sendingResult
        } catch {
            throw Web3ManagerError.transactionFailed
        }
    }

    func getTransactionDetails(txHash: Data) async throws -> TransactionDetails {
        do {
            let transactionDetails = try await web3.eth.transactionDetails(txHash)
            return transactionDetails
        } catch {
            throw Web3ManagerError.unableToFetchTransactionDetails
        }
    }
}
