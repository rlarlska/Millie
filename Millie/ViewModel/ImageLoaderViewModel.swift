//
//  ImageLoaderViewModel.swift
//  Millie
//
//  Created by 김기남 on 2024/05/09.
//

import UIKit

class ImageLoaderViewModel: ObservableObject {
    @Published var image: UIImage?
    
    func loadImage(from url: URL) async -> Data? {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            return try await withCheckedThrowingContinuation { continuation in
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else {
                        continuation.resume(returning: nil)
                        return
                    }
                    self.image = UIImage(data: data)
                    
                    continuation.resume(returning: data)
                }
            }
            
        } catch {
            print("\(error)")
            return nil
        }
    }
}
