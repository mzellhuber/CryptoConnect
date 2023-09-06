//
//  CustomButton.swift
//  CryptoConnect
//
//  Created by Melissa Zellhuber on 06/09/23.
//

import SwiftUI

struct CustomButton: View {
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            Text(title)
                .font(Typography.bodyText)
                .foregroundColor(.white)
                .padding(.vertical, 12)
                .padding(.horizontal)
                .background(ColorPalette.buttonBackground)
                .cornerRadius(8)
        })
    }
}

#Preview {
    CustomButton(title: "Test", action: {})
}
