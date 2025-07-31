//
//  RealmLocalData.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 29/07/25.
//

import RealmSwift

final class RealmLocalData {
    private let realm: Realm?
    
    init() {
        do {
            realm = try Realm()
        } catch {
            realm = nil
        }
    }
}

extension RealmLocalData: ILocalUser {
    func save(_ user: User) {
        guard let realm else { return }
        do {
            try realm.write {
                let existingUsers = realm.objects(RealmUser.self)
                realm.delete(existingUsers)
                
                // Then, add the new one
                realm.add(user.mapToRealmUser())
            }
        } catch {
            print("Realm Failed to save user: \(error.localizedDescription)")
        }
    }
    
    func load() -> User? {
        guard let realm else { return nil }
        return realm.objects(RealmUser.self).first?.mapToUser()
    }
    
    func delete() {
        guard let realm else { return }
        guard let user = realm.objects(RealmUser.self).first else { return }
        
        do {
            try realm.write {
                realm.delete(user)
            }
        } catch {
            print("Realm Failed to delete user: \(error.localizedDescription)")
        }
    }
}
