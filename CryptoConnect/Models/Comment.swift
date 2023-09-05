//
//  Comment.swift
//  CryptoConnect
//
//  Created by Melissa Zellhuber on 04/09/23.
//

import Foundation

struct Comment: Identifiable {
    let id: UUID
    let username: String
    let timestamp: Date
    let body: String
}
