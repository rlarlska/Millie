//
//  WebImageView.swift
//  Millie
//
//  Created by 김기남 on 2024/05/09.
//

import SwiftUI

struct WebImageView: View {
    @StateObject private var imageLoaderViewModel = ImageLoaderViewModel()
    let imageURL: URL
    let imageData: Data?
    let completion: (Data) -> Void
    
    var body: some View {
        Group {
            if let image = imageLoaderViewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                ProgressView()
            }
        }
        .onAppear {
            if let imageData = imageData, let image = UIImage(data: imageData) {
                self.imageLoaderViewModel.image = image
            } else {
                Task {
                    guard let data = await imageLoaderViewModel.loadImage(from: imageURL) else {
                        return
                    }
                    
                    DispatchQueue.main.async {
                        completion(data)
                    }
                }
            }
        }
    }
}
