//
//  HomeViewModel.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 31/07/25.
//

import RxSwift
import RxRelay

protocol IHomeViewModel {
    var pokemons: BehaviorRelay<[Pokemon]> { get }
    func loadMoreIfNeeded()
}

final class HomeViewModel: IHomeViewModel {
    private(set) var pokemons = BehaviorRelay<[Pokemon]>(value: [])
    private var isLoading = false
    private let loader: IPokemonListLoader
    
    init(loader: IPokemonListLoader) {
        self.loader = loader
    }

    func loadMoreIfNeeded() {
        if !isLoading {
            loadPage()
        }
    }

    private func loadPage() {
        guard !isLoading else { return }
        isLoading = true

        let urlComposer = PokemonListURLComposer(pokemonList: pokemons.value)
        loader.load(urlComposer) { [weak self] result in
            switch result {
            case .success(let success):
                self?.pokemons.accept(success)
            case .failure(let failure):
                break
            }
            self?.isLoading = false
        }
    }
}
