//
//  SceneDelegate.swift
//  ImageDownloader
//
//  Created by Wonbi on 2023/02/28.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let networkManager = NetworkManager()
        let imageManager = ImageManager(networkManager: networkManager)
        let rootViewController = DownloadViewController(imageManager: imageManager)
        
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        self.window = window
    }
}

