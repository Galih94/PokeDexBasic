//
//  ILocalUser.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 29/07/25.
//


public protocol ILocalUser {
    func save(_ user: User)
    func load() -> User?
    func delete()
}
