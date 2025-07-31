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
        goToLogin()
    }
}

// Login
extension AppCoordinator {
    func composeLoginVC() -> LoginViewController {
        let loader = RealmLocalData()
        return LoginComposer.compose(loader: loader, onRegister: { [weak self] in
            self?.goToMainTab()
        })
    }
    
    func goToLogin() {
        let vc = composeLoginVC()
        navigationController.setViewControllers([vc], animated: false)
    }
}

// Main Tab
extension AppCoordinator {
    func composeMainTabVC() -> MainTabViewController {
        return MainPageComposer.compose(onTappedPokemon: { [weak self] pokemon in
            self?.goToDetail()
        })
    }
    
    func goToMainTab() {
        let vc = composeMainTabVC()
        navigationController.pushViewController(vc, animated: true)
    }
}

// Detail
extension AppCoordinator {
    func composeDetailVC() -> DetailViewController {
        return DetailComposer.compose()
    }
    
    func goToDetail() {
        let vc = composeDetailVC()
        navigationController.setViewControllers([vc], animated: false)
    }
}
