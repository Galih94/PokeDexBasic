//
//  HomeViewModel.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 31/07/25.
//

import RxSwift
import RxRelay



final class HomeViewModel: IHomeViewModel {
    let isLoadingDetail = BehaviorRelay<Bool?>(value: nil)
    var onTappedPokemon: ((Pokemon) -> Void)?
    var onSearchError: (() -> Void)?
    private(set) var pokemons = BehaviorRelay<[Pokemon]>(value: [])
    private var isLoading = false
    private let loader: IPokemonListLoader
    private let detailLoader: IPokemonDetailLoader
    private var onShowPokemonDetail: ((PokemonDetail) -> Void)?
    
    init(detailLoader: IPokemonDetailLoader,
         loader: IPokemonListLoader,
         onTappedPokemon: ((Pokemon) -> Void)?,
         onShowPokemonDetail: ((PokemonDetail) -> Void)?) {
        self.loader = loader
        self.onTappedPokemon = onTappedPokemon
        self.detailLoader = detailLoader
        self.onShowPokemonDetail = onShowPokemonDetail
    }
    
    func loadPage() {
        guard !isLoading else { return }
        isLoading = true
        loader.load { [weak self] result in
            switch result {
            case .success(let success):
                self?.pokemons.accept(success)
            case .failure:
                break
            }
            self?.isLoading = false
        }
    }
    
    func searchPokemon(_ name: String) {
        isLoadingDetail.accept(true)
        detailLoader.load(name: name) { [weak self] result in
            self?.isLoadingDetail.accept(false)
            switch result {
            case .success(let pokemonDetail):
                self?.onShowPokemonDetail?(pokemonDetail)
            case .failure:
                self?.onSearchError?()
            }
        }
    }
}
