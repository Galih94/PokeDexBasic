//
//  LoginViewModel.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 29/07/25.
//

final class LoginViewModel: ILoginViewModel {
    var onRegister: () -> Void
    let loader: ILocalUser
    
    init(loader: ILocalUser, onRegister: @escaping () -> Void) {
        self.loader = loader
        self.onRegister = onRegister
    }
    func register(_ name: String) {
        loader.save(User(name: name))
        onRegister()
    }
}
