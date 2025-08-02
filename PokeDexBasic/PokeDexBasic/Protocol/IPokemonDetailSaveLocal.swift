//
//  IPokemonDetailSaveLocal.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 02/08/25.
//


import RealmSwift

protocol IPokemonDetailSaveLocal {
    func save(_ pokemonDetail: PokemonDetail)
}