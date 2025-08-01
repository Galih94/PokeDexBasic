//
//  MainPageComposer.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 30/07/25.
//

enum MainPageComposer {
    static func compose(apiService: IPokemonAPIService, onTappedPokemon: ((Pokemon) -> Void)?) -> MainTabViewController {
        let profileViewModel = ProfileViewModel(loader: RealmLocalData())
        let homeViewModel = HomeViewModel(loader: RemotePokemonListLoader(apiService: apiService), onTappedPokemon: onTappedPokemon)
        let profile = ProfileViewController(viewModel: profileViewModel)
        let home = HomeViewController(viewModel: homeViewModel)
        let mainTab = MainTabViewController(pages: [home, profile])
        
        return mainTab
    }
}
