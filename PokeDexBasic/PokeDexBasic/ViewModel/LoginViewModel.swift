//
//  LoginViewModel.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 29/07/25.
//

final class LoginViewModel: ILoginViewModel {
    var onRegisterSuccess: () -> Void
    let loader: ILocalUser
    
    init(loader: ILocalUser, onRegisterSuccess: @escaping () -> Void) {
        self.loader = loader
        self.onRegisterSuccess = onRegisterSuccess
    }
    func register(_ name: String) {
        loader.save(User(name: name))
        onRegisterSuccess()
    }
}
