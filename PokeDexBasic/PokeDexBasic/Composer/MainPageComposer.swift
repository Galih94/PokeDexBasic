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
        
        let remoteDetailLoader = RemotePokemonDetailLoader(apiService: apiService)
        let localDetailLoader = LocalPokemonDetailLoader()
        let detailLoader = FallbackPokemonDetailLoader(remote: remoteDetailLoader, local: localDetailLoader)
        
        let remoteLoader = RemotePokemonListLoader(apiService: apiService, dataComposer: PokemonListDataComposer(pokemonList: []))
        let localLoader = LocalPokemonListLoader()
        let loader = FallbackPokemonListLoader(remote: remoteLoader, local: localLoader)
        
        let homeViewModel = HomeViewModel(detailLoader: MainQueueDispatchDecorator(decoratee: detailLoader),
                                          loader: MainQueueDispatchDecorator(decoratee: loader),
                                          onTappedPokemon: onTappedPokemon,
                                          onShowPokemonDetail: onShowPokemonDetail
        )
        let profile = ProfileViewController(viewModel: profileViewModel)
        let home = HomeViewController(viewModel: homeViewModel)
        let mainTab = MainTabViewController(pages: [home, profile])
        
        return mainTab
    }
}
