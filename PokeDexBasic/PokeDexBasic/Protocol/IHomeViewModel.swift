//
//  IHomeViewModel.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 02/08/25.
//


import RxSwift
import RxRelay

protocol IHomeViewModel {
    var onSearchError: (() -> Void)? { get set }
    var pokemons: BehaviorRelay<[Pokemon]> { get }
    var onTappedPokemon: ((Pokemon) -> Void)? { get set }
    var isLoadingDetail: BehaviorRelay<Bool?> { get }
    func loadPage()
    func searchPokemon(_ name: String)
}