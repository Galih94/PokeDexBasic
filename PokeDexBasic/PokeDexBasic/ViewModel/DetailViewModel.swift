//
//  DetailViewModel.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 31/07/25.
//

import RxSwift

protocol IDetailViewModel {
    var onBackTapped: (() -> Void)? { get set }
    var pokemonDetail: BehaviorSubject<PokemonDetail?> { get }
    
    func loadDetails()
}

final class DetailViewModel: IDetailViewModel {
    
    var onBackTapped: (() -> Void)?
    let loader: IPokemonDetailLoader
    let pokemonName: String
    var name: String = ""
    var abilities: [String] = []
    var pokemonDetail: BehaviorSubject<PokemonDetail?>

    init(
        loader: IPokemonDetailLoader,
        pokemonName: String,
        onBackTapped: (() -> Void)?,
        defaultPokemonDetail: PokemonDetail?
    ) {
        self.loader = loader
        self.pokemonName = pokemonName
        self.onBackTapped = onBackTapped
        self.pokemonDetail = BehaviorSubject<PokemonDetail?>(value: defaultPokemonDetail)
    }

    func loadDetails() {
        guard (try? pokemonDetail.value()) == nil else {
            return
        }
        loader.load(name: pokemonName) { [weak self] result in
            switch result {
            case .success(let detail):
                self?.pokemonDetail.onNext(detail)
            case .failure( _):
                break  
            }
        }
    }
}
