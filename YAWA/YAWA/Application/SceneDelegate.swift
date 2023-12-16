//
//  SceneDelegate.swift
//  YAWA
//
//  Created by Bassist Zero on 11/21/23.
//

import UIKit

final class SceneDelegate: UIResponder {

    var window: UIWindow?

}

// MARK: - UIWindowSceneDelegate

extension SceneDelegate: UIWindowSceneDelegate {

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        configureWindow(with: scene)
    }

}

// MARK: - Private Methods

private extension SceneDelegate {

    func configureWindow(with scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = MainTabBarController()
        window?.makeKeyAndVisible()
    }

    func implementThisAppWithBestPracticesOnlyJust<DoIt>(iThink iWill: Never) -> DoIt { }

}
