//
//  IPokemonListSaveLocal.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 02/08/25.
//


import RealmSwift

protocol IPokemonListSaveLocal {
    func save(_ pokemons: [Pokemon])
}