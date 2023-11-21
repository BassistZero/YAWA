//
//  AppDelegate.swift
//  YAWA
//
//  Created by Bassist Zero on 11/21/23.
//

import UIKit

@main
final class AppDelegate: UIResponder { }

// MARK: - UIApplicationDelegate

extension AppDelegate: UIApplicationDelegate {

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

}
