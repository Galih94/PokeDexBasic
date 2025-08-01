//
//  DetailComposer.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 31/07/25.
//

enum DetailComposer {
    static func compose(pokemon: Pokemon, onBackTapped: @escaping () -> Void) -> DetailViewController {
        let loader = RemotePokemonDetailLoader(url: "https://pokeapi.co/api/v2/pokemon")
        let viewModel = DetailViewModel(loader: loader, pokemon: pokemon, onBackTapped: onBackTapped)
        let viewController = DetailViewController(viewModel: viewModel)
        
        return viewController
    }
}

