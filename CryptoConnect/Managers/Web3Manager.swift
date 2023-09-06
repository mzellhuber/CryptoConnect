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
    case unableToFetchGasPrice
    case unableToEstimateGas
    
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
        case .unableToFetchGasPrice:
            return "Unable to fetch gas price."
        case .unableToEstimateGas:
            return "Unable to estimate gas."
        }
    }
}

class Web3Manager: ObservableObject {
    @Published var web3: Web3?

    init(provider: Web3Provider? = nil) {
        if let provider = provider {
            self.web3 = Web3(provider: provider)
        }
    }
    
    func setProviderAsync() async {
        do {
            let infura = try await InfuraProvider(net: Networks.Kovan, accessToken: "test")
            self.web3 = Web3(provider: infura)
        } catch {
            // Handle error
            print("Error setting provider: \(error.localizedDescription)")
        }
    }
    
    func getGasPrice() async throws -> BigUInt {
        guard let web3 = web3 else {
            throw Web3ManagerError.unableToFetchGasPrice
        }
        let gasPrice = try await web3.eth.gasPrice()
        return gasPrice
    }
    
    func estimateGas(transaction: CodableTransaction) async throws -> BigUInt {
        guard let web3 = web3 else {
            throw Web3ManagerError.unableToEstimateGas
        }
        let gasLimit = try await web3.eth.estimateGas(for: transaction)
        return gasLimit
    }
    
    func createWallet(password: String) async throws -> EthereumKeystoreV3 {
        guard let keystore = try? EthereumKeystoreV3(password: password) else {
            throw Web3ManagerError.invalidKeystore
        }
        let keystoreManager = KeystoreManager([keystore])
        web3?.addKeystoreManager(keystoreManager)
        return keystore
    }
    
    func importWallet(privateKey: String, password: String) async throws -> EthereumKeystoreV3 {
        let dataKey = Data(hex: privateKey)
        guard let keystore = try? EthereumKeystoreV3(privateKey: dataKey, password: password) else {
            throw Web3ManagerError.invalidPrivateKey
        }
        let keystoreManager = KeystoreManager([keystore])
        web3?.addKeystoreManager(keystoreManager)
        return keystore
    }
    
    func getBalance(address: EthereumAddress) async throws -> BigUInt {
        guard let web3 = web3 else {
            throw Web3ManagerError.unableToFetchBalance
        }
        let balance = try await web3.eth.getBalance(for: address, onBlock: .latest)
        return balance
    }
    
    func sendTransaction(to: EthereumAddress, value: BigUInt, gasPrice: BigUInt, gasLimit: BigUInt) async throws -> TransactionSendingResult {
        guard let web3 = web3 else {
            throw Web3ManagerError.transactionFailed
        }
        var transaction = CodableTransaction(to: to)
        transaction.value = value
        transaction.gasPrice = gasPrice
        transaction.gasLimit = gasLimit
        let sendingResult = try await web3.eth.send(transaction)
        return sendingResult
    }
    
    func getTransactionDetails(txHash: Data) async throws -> TransactionDetails {
        guard let web3 = web3 else {
            throw Web3ManagerError.unableToFetchTransactionDetails
        }
        let transactionDetails = try await web3.eth.transactionDetails(txHash)
        return transactionDetails
    }
}
