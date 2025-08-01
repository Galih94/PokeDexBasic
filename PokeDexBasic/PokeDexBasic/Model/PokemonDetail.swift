//
//  PokemonDetail.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 01/08/25.
//


struct PokemonDetail {
    public let name: String
    public let imageURL: String
    public let abilities: [String]
    
    public init(name: String, imageURL: String, abilities: [String]) {
        self.name = name
        self.imageURL = imageURL
        self.abilities = abilities
    }
}