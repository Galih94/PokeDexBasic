//
//  IDetailViewModel.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 02/08/25.
//


import RxSwift
import RxRelay

protocol IDetailViewModel {
    var onBackTapped: (() -> Void)? { get set }
    var pokemonDetail: BehaviorSubject<PokemonDetail?> { get }
    var isLoading: BehaviorRelay<Bool?> { get }
    
    func loadDetails()
}