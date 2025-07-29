//
//  RealmLocalData.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 29/07/25.
//

final class RealmLocalData {
    init () {}
}

extension RealmLocalData: ILocalUser {
    func save(_ user: User) {
        
    }
    
    func load() -> User? {
        return nil
    }
    
    func delete() {
        
    }
    
    
}
