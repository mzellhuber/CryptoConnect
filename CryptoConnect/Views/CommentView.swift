//
//  CommentView.swift
//  CryptoConnect
//
//  Created by Melissa Zellhuber on 06/09/23.
//

import SwiftUI

struct CommentView: View {
    let comment: Comment
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    var body: some View {
        ZStack {
            ColorPalette.secondaryBackground
                .cornerRadius(10)
                .shadow(color: .gray.opacity(0.5), radius: 2, x: 0, y: 2)
            
            VStack(alignment: .center, spacing: 10) {
                Text(comment.username)
                    .font(Typography.bodyText)
                    .foregroundColor(ColorPalette.primaryText)
                    .padding(.top)
                
                Text(dateFormatter.string(from: comment.timestamp))
                    .font(Typography.caption)
                    .foregroundColor(ColorPalette.secondaryText)
                
                Text(comment.body)
                    .font(Typography.bodyText)
                    .foregroundColor(ColorPalette.primaryText)
                    .padding(.bottom)
            }
            .padding(.horizontal)
        }
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView(comment: Comment(id: UUID(), username: "Jane Doe", timestamp: Date(), body: "This is a sample comment"))
    }
}
