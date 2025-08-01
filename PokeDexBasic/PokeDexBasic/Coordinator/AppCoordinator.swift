//
//  AppCoordinator.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 30/07/25.
//

import UIKit

final class AppCoordinator {
    private let navigationController: UINavigationController
    private let apiService = PokemonAPIService()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        goToLogin()
    }
    
    func pop() {
        navigationController.popViewController(animated: true)
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
        return MainPageComposer.compose(apiService: apiService, onTappedPokemon: { [weak self] pokemon in
            self?.goToDetail(pokemon: pokemon)
        })
    }
    
    func goToMainTab() {
        let vc = composeMainTabVC()
        navigationController.pushViewController(vc, animated: true)
    }
}

// Detail
extension AppCoordinator {
    func composeDetailVC(pokemon: Pokemon) -> DetailViewController {
        return DetailComposer.compose(pokemon: pokemon, apiService: apiService, onBackTapped: { [weak self]  in
            self?.pop()
        })
    }
    
    func goToDetail(pokemon: Pokemon) {
        let vc = composeDetailVC(pokemon: pokemon)
        navigationController.pushViewController(vc, animated: true)
    }
}
