//
//  LoginViewModel.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 29/07/25.
//

final class LoginViewModel {
    let loader: ILocalUser
    
    init(loader: ILocalUser) {
        self.loader = loader
    }
}

extension LoginViewModel: ILoginViewModel {
    func register(_ name: String) {
        loader.save(User(name: name))
    }
}
