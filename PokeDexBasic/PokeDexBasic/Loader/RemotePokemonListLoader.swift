//
//  RemotePokemonListLoader.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 31/07/25.
//

import Alamofire

final class RemotePokemonListLoader: IPokemonListLoader {
    func load(_ urlGenerator: IPokemonListURLComposer, completion: @escaping (Result<[Pokemon], Error>) -> Void) {
        
    }
}
