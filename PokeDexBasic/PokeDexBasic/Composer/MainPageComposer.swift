//
//  MainPageComposer.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 30/07/25.
//

enum MainPageComposer {
    static func compose(apiService: IPokemonAPIService,
                        onTappedPokemon: ((Pokemon) -> Void)?,
                        onShowPokemonDetail: ((PokemonDetail) -> Void)?
    ) -> MainTabViewController {
        let profileViewModel = ProfileViewModel(loader: RealmLocalData())
        let detailLoader = RemotePokemonDetailLoader(apiService: apiService)
        let loader = RemotePokemonListLoader(apiService: apiService)
        let homeViewModel = HomeViewModel(detailLoader: detailLoader,
                                          loader: loader,
                                          onTappedPokemon: onTappedPokemon,
                                          onShowPokemonDetail: onShowPokemonDetail
        )
        let profile = ProfileViewController(viewModel: profileViewModel)
        let home = HomeViewController(viewModel: homeViewModel)
        let mainTab = MainTabViewController(pages: [home, profile])
        
        return mainTab
    }
}
