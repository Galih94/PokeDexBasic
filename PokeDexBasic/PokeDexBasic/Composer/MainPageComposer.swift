//
//  MainPageComposer.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 30/07/25.
//

enum MainPageComposer {
    static func compose(onTappedPokemon: ((Pokemon) -> Void)?) -> MainTabViewController {
        let profileViewModel = ProfileViewModel(loader: RealmLocalData())
        let homeViewModel = HomeViewModel(loader: RemotePokemonListLoader(), onTappedPokemon: onTappedPokemon)
        let profile = ProfileViewController(viewModel: profileViewModel)
        let home = HomeViewController(viewModel: homeViewModel)
        let mainTab = MainTabViewController(pages: [home, profile])
        
        return mainTab
    }
}
