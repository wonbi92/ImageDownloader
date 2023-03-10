//
//  NetworkManager.swift
//  ImageDownloader
//
//  Created by Wonbi on 2023/02/28.
//

import Foundation

enum ImageError: LocalizedError {
    case badID, badData, badImage
    
    var localizedDescription: String {
        switch self {
        case .badID:
            return "이미지의 ID가 잘못되어있습니다."
        case .badData:
            return "잘못된 Data입니다."
        case .badImage:
            return "섬네일 변환에 실패하였습니다."
        }
    }
}

final class NetworkManager {
    private let session: URLSession
    private let imageIDs: [String] = [
        "europe-4k-1369012",
        "europe-4k-1318341",
        "europe-4k-1379801",
        "cool-lion-167408",
        "iron-man-323408"
    ]
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    private func createImageURL(from index: Int) -> URL? {
        let id = imageIDs[index]
        
        return URL(string: "https://wallpaperaccess.com/download/" + id)
    }
    
    private func createImageURLRequest(for index: Int) -> URLRequest? {
        guard let url = createImageURL(from: index) else { return nil }
        
        return URLRequest(url: url)
    }
    
    func fetchData(for index: Int, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let request = createImageURLRequest(for: index) else { return }
                
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let statusCode = (response as? HTTPURLResponse)?.statusCode,
               !(200...299).contains(statusCode) {
                completion(.failure(ImageError.badID))
                return
            }
            
            guard let data = data else {
                completion(.failure(ImageError.badData))
                return
            }
            
            completion(.success(data))
            
        }
        task.resume()
    }
}
