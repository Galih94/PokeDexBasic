//
//  ProfileViewModel.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 30/07/25.
//


final class ProfileViewModel: IProfileViewModel {
    let loader: ILocalUser
    
    init(loader: ILocalUser) {
        self.loader = loader
    }
    
    func getName() -> String? {
        return loader.load()?.name
    }
}

