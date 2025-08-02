//
//  PokemonDetailLoaderSpy.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 02/08/25.
//


import XCTest
@testable import PokeDexBasic

enum PokemonDetailLoaderRequests: Equatable  {
    case load(String)
}

enum MockPokemonDetail {
    static let obj: PokemonDetail = PokemonDetail(name: "test pokemon detail name", imageURL: "https://test-url.com", abilities: ["test"])
}

final class PokemonDetailLoaderSpy: IPokemonDetailLoader {
    var requests: [PokemonDetailLoaderRequests] = []
    var setResultCompletionSuccess: Bool = true
    
    func load(name: String, completion: @escaping (Result<PokemonDetail, Error>) -> Void) {
        requests.append(.load(name))
        if setResultCompletionSuccess {
            completion(.success(MockPokemonDetail.obj))
        } else {
            let error = NSError(domain: "Test", code: 1, userInfo: [NSLocalizedDescriptionKey: "Mock error"])
            completion(.failure(error))
        }
    }
}
