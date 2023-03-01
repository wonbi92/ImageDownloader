//
//  ImageManager.swift
//  ImageDownloader
//
//  Created by Wonbi on 2023/03/01.
//

import UIKit

enum ImageError: Error {
    case badData, badImage
}

final class ImageManager {
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func createThumbnail(for index: Int, completion: @escaping (Result<UIImage, Error>) -> Void) {
        networkManager.fetchData(for: index) { result in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else {
                    completion(.failure(ImageError.badData))
                    return
                }
                
                image.prepareThumbnail(of: CGSize(width: 160, height: 90)) { thumbnail in
                    guard let thumbnail = thumbnail else {
                        completion(.failure(ImageError.badImage))
                        return
                    }
                    completion(.success(thumbnail))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
