//
//  NetworkManager.swift
//  ImageDownloader
//
//  Created by Wonbi on 2023/02/28.
//

import Foundation

final class NetworkManager {
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
}
