//
//  ProfileViewModel.swift
//  CryptoConnect
//
//  Created by Melissa Zellhuber on 04/09/23.
//

import Foundation
import SwiftUI
import Combine
import Web3Core

class ProfileViewModel: ObservableObject {
    @Published var username: String = "John Doe"
    @Published var email: String = "john.doe@example.com"
    @Published var profilePicture: Image = Image(systemName: "person.circle")
    @Published var walletAddress: EthereumAddress?

    // Add other user profile properties here
    
    init() {
        // Initialize with default values or fetch user data from a network request or local storage
    }
    
    func fetchUserProfile() {
        // Your code to fetch user profile data and assign to the properties
        // Don't forget to fetch and assign the wallet address here
    }
}
