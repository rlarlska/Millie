//
//  GridItemView.swift
//  Millie
//
//  Created by 김기남 on 2024/05/10.
//

import SwiftUI

protocol GridItemView {
    var title: String { get set }
    var isRead: Bool { get set }
    var urlToImage: String? { get set }
    var imageData: Data? { get set }
    var publishedAt: String { get set }
    var completion: (Data) -> Void { get }
}

struct PortraitGridItemView: View, GridItemView {
    var title: String
    var isRead: Bool
    var urlToImage: String?
    var imageData: Data?
    var publishedAt: String
    var completion: (Data) -> Void
    
    var body: some View {
        VStack {
            Text(title)
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(isRead ? Color.red : Color.primary)
            
            if let urlString = urlToImage, let url = URL(string: urlString) {
                WebImageView(
                    imageURL: url,
                    imageData: imageData
                ) { data in
                    completion(data)
                }
            }
            
            HStack {
                Spacer()
                Text(publishedAt)
            }
        }
    }
}

struct LandscapeGridItemView: View, GridItemView {
    var title: String
    var isRead: Bool
    var urlToImage: String?
    var imageData: Data?
    var publishedAt: String
    var completion: (Data) -> Void
    
    var body: some View {
        HStack {
            VStack {
                Spacer()
                Text(title)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(isRead ? Color.red : Color.primary)
                Spacer()
                HStack {
                    Spacer()
                    Text(publishedAt)
                }
            }
            
            if let urlString = urlToImage, let url = URL(string: urlString) {
                WebImageView(
                    imageURL: url,
                    imageData: imageData
                ) { data in
                    completion(data)
                }
                .frame(width: 50, height: 50)
            }
        }
    }
}
