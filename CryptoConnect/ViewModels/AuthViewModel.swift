//
//  AuthViewModel.swift
//  CryptoConnect
//
//  Created by Melissa Zellhuber on 04/09/23.
//

import Foundation
import web3swift
import Web3Core
import BigInt

class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var user: User?
    
    private var keystoreManager: KeystoreManager?
    
    // Method to register a new user
    func registerUser(username: String, email: String, password: String) {
        // Here, add the code to register a new user, possibly saving the user details to a database
        // ...

        // After successfully registering the user, you can authenticate the user and update the user property
        self.user = User(walletAddress: "", username: username, email: email) // walletAddress will be updated when the wallet is created or imported
        self.isAuthenticated = true
    }
    
    // Method to log in a registered user
    func loginUser(username: String, password: String) {
        // Here, add the code to authenticate the user with the given username and password
        // ...

        // After successfully authenticating the user, you can update the user property with the user's details
        // self.user = User(walletAddress: "", username: username, email: "") // Retrieve the user's details from the database
        // self.isAuthenticated = true
    }
    
    func createWallet(withMnemonics mnemonics: String, password: String) {
        do {
            if let keystore = try? BIP32Keystore(mnemonics: mnemonics, password: password, mnemonicsPassword: password),
               let address = keystore.addresses?.first?.address {
                self.keystoreManager = KeystoreManager([keystore])
                self.user?.walletAddress = address
                self.isAuthenticated = true
            } else {
                // Handle error
                print("Error creating wallet")
            }
        }
    }
    
    func importWallet(privateKey: String, password: String) {
        let privateKeyData = Data(hex: privateKey)
        do {
            let keystore = try EthereumKeystoreV3(privateKey: privateKeyData, password: password)!
            if let address = keystore.addresses?.first?.address {
                self.keystoreManager = KeystoreManager([keystore])
                self.user?.walletAddress = address
                self.isAuthenticated = true
            }
        } catch {
            // Handle error
            print("Error importing wallet: \(error)")
        }
    }
}
