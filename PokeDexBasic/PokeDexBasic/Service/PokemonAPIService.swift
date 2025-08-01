//
//  PokemonAPIService.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 01/08/25.
//

import Alamofire
import Foundation

protocol IPokemonAPIService {
    func request(url: String, completion: @escaping (Result<Data, Error>) -> Void)
}

class PokemonAPIService: IPokemonAPIService {
    private let session: Session
    
    init(session: Session = .default) {
        self.session = session
    }
    
    func request(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        session.request(url)
            .validate()
            .responseData { response in
                switch response.result {
                case let .success(data):
                    completion(.success(data))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
    }
}

