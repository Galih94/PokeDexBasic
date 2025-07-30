//
//  SceneDelegate.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 30/07/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var rooter: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController()
        let rooter = AppCoordinator(navigationController: navigationController)
        self.rooter = rooter
        self.rooter?.start()
        
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
    }


}

