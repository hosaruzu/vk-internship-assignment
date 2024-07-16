//
//  SceneDelegate.swift
//  vk-internship-assignment
//
//  Created by Artem Tebenkov on 16.07.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        setupUI(on: windowScene)
    }

    func setupUI(on scene: UIWindowScene) {
        let viewController = MainAssembly().build()
        window = UIWindow(windowScene: scene)
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
}
