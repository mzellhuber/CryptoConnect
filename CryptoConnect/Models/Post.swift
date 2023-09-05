//
//  Post.swift
//  CryptoConnect
//
//  Created by Melissa Zellhuber on 04/09/23.
//

import Foundation

struct Post: Identifiable {
    let id: UUID
    let title: String
    let body: String
    let timestamp: Date
}
