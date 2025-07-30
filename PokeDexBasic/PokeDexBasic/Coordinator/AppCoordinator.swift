//
//  AppCoordinator.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 30/07/25.
//

import UIKit

final class AppCoordinator {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = composeLoginVC()
        navigationController.setViewControllers([vc], animated: false)
    }
}

// Login
extension AppCoordinator {
    func composeLoginVC() -> LoginViewController {
        let loader = RealmLocalData()
        return LoginComposer.compose(loader: loader, onRegisterSuccess: {
            
        })
    }
}
