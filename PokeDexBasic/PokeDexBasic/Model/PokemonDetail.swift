//
//  PokemonDetail.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 01/08/25.
//

import RealmSwift

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

class RealmPokemonDetail: Object {
    @Persisted var name: String = ""
    @Persisted var imageURL: String = ""
    @Persisted var abilities = List<String>()
    
    convenience init(from pokemonDetail: PokemonDetail) {
        self.init()
        self.name = pokemonDetail.name
        self.imageURL = pokemonDetail.imageURL
        self.abilities.append(objectsIn: pokemonDetail.abilities)
    }
    
    func mapToPokemonDetail() -> PokemonDetail {
        return PokemonDetail(
            name: name,
            imageURL: imageURL,
            abilities: Array(abilities)
        )
    }
}
