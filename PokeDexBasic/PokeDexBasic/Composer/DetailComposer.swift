//
//  DetailComposer.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 31/07/25.
//

enum DetailComposer {
    static func compose(pokemonName: String,
                        defaultPokemonDetail: PokemonDetail?,
                        apiService: IPokemonAPIService,
                        onBackTapped: @escaping () -> Void) -> DetailViewController {
        let loader = RemotePokemonDetailLoader(apiService: apiService)
        let viewModel = DetailViewModel(loader: MainQueueDispatchDecorator(decoratee: loader),
                                        pokemonName: pokemonName,
                                        onBackTapped: onBackTapped,
                                        defaultPokemonDetail: defaultPokemonDetail)
        let viewController = DetailViewController(viewModel: viewModel)
        
        return viewController
    }
}

