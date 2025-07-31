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
        print("res hit load")
        guard !isLoading else { return }
        isLoading = true
        print("res hit load success")
        let dataComposer = PokemonListDataComposer(pokemonList: pokemons.value)
        loader.load(dataComposer) { [weak self] result in
            switch result {
            case .success(let success):
                self?.pokemons.accept(success)
            case .failure:
                break
            }
            self?.isLoading = false
        }
    }
}
