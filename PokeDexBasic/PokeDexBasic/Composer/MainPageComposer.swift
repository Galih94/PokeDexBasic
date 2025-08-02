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
        let remoteLoader = RemotePokemonListLoader(apiService: apiService)
        let localLoader = LocalPokemonListLoader()
        let loader = FallbackPokemonListLoader(remote: remoteLoader, local: localLoader)
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
