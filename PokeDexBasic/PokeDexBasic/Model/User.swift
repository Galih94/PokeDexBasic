//
//  User.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 29/07/25.
//

import RealmSwift

public struct User: Equatable  {
    public let name: String
    
    public init(name: String) {
        self.name = name
    }
    
    func mapToRealmUser() -> RealmUser {
        let obj = RealmUser()
        obj.name = name
        return obj
    }
}

class RealmUser: Object {
    @Persisted var name: String = ""
    
    func mapToUser() -> User {
        return User(name: name)
    }
}
