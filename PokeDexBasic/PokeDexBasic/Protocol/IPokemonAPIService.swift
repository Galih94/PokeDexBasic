//
//  IPokemonAPIService.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 02/08/25.
//


import Alamofire
import Foundation

protocol IPokemonAPIService {
    func request(url: String, completion: @escaping (Result<Data, Error>) -> Void)
}