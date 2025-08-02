//
//  IPokemonDetailLoader.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 02/08/25.
//


import Alamofire
import Foundation

protocol IPokemonDetailLoader {
    typealias Result = Swift.Result<PokemonDetail, Error>
    
    func load(name: String, completion: @escaping (Result) -> Void)
}

extension MainQueueDispatchDecorator: IPokemonDetailLoader where T == IPokemonDetailLoader {
    func load(name: String, completion: @escaping (IPokemonDetailLoader.Result) -> Void) {
        decoratee.load(name: name) { [weak self] result in
            self?.dispatch {
                completion(result)
            }
        }
    }
}
