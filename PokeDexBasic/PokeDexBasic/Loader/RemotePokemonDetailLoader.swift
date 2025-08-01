//
//  RemotePokemonDetailLoader.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 01/08/25.
//

import Alamofire
import Foundation

protocol IPokemonDetailLoader {
    typealias Result = Swift.Result<PokemonDetail, Error>
    
    func load(name: String, completion: @escaping (Result) -> Void)
}

final class RemotePokemonDetailLoader: IPokemonDetailLoader {
    private let url: String
    
    enum Error: Swift.Error {
        case connectivity
        case invalidData
        case notFoundImageURL
    }
    
    typealias Result = IPokemonDetailLoader.Result
    
    init (url: String) {
        self.url = url
    }
    
    func load(name: String, completion: @escaping (Result) -> Void) {
        AF.request(url + "/\(name)").validate().responseData  { [weak self] response in
            guard self != nil else { return }
            switch response.result {
            case let .success(data):
                completion(RemotePokemonDetailLoader.map(data: data))
            case .failure( _):
                completion(.failure(Error.connectivity))
            }
        }
    }
    
    private static func map(data: Data) -> Result {
        do {
            let pokemonDetail = try PokemonDetailMapper.map(data)
            return .success(pokemonDetail)
        } catch {
            return .failure(error)
        }
    }
}


enum PokemonDetailMapper {
    static func map(_ data: Data) throws -> PokemonDetail {
        guard let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            throw RemotePokemonDetailLoader.Error.invalidData
        }
        
        let name = dict["name"] as? String ?? ""
        
        guard let sprite = dict["sprites"] as? [String: Any],
              let imageUrlString = sprite["front_default"] as? String else {
            throw RemotePokemonDetailLoader.Error.notFoundImageURL
        }
        
        let abilities = dict["abilities"] as? [[String: Any]] ?? []
        let abilityNames = abilities.map { abilityObj in
            let ability = abilityObj["ability"] as? [String: Any]
            let name = ability?["name"] as? String ?? ""
            return name
        }
        
        return PokemonDetail(name: name, imageURL: imageUrlString, abilities: abilityNames)
    }
}
