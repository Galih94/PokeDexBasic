//
//  DetailViewModel.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 31/07/25.
//

import RxSwift

protocol IDetailViewModel {
    var onBackTapped: (() -> Void)? { get set }
    var pokemonDetail:  PublishSubject<PokemonDetail> { get }
    
    func loadDetails()
}

final class DetailViewModel: IDetailViewModel {
    
    var onBackTapped: (() -> Void)?
    let loader: IPokemonDetailLoader
    let pokemon: Pokemon
    var name: String = ""
    var abilities: [String] = []
    var pokemonDetail = PublishSubject<PokemonDetail>()
    
    
    init(loader: IPokemonDetailLoader, pokemon: Pokemon, onBackTapped: (() -> Void)?) {
        self.loader = loader
        self.pokemon = pokemon
        self.onBackTapped = onBackTapped
    }
    
    func loadDetails() {
        loader.load(name: pokemon.name, completion: { [weak self] result in
            switch result {
            case .success(let detail):
                self?.pokemonDetail.onNext(detail)
            case .failure(let error):
                print("Error: \(error)")
            }
        })
    }
}
