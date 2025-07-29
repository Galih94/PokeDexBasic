//
//  LoginComposer.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 29/07/25.
//

public enum LoginComposer {
    public static func compose(loader: ILocalUser) -> LoginViewController {
        let viewModel = LoginViewModel(loader: loader)
        let viewController = LoginViewController(viewModel: viewModel)
        
        return viewController
    }
}
