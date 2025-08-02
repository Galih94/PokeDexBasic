//
//  LocalUserDataSpy.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 30/07/25.
//

@testable import PokeDexBasic

enum LocalUserRequests: Equatable  {
    case save(User), load, delete
    static func == (lhs: LocalUserRequests, rhs: LocalUserRequests) -> Bool {
        switch (lhs, rhs) {
        case let (.save(lhsUser), .save(rhsUser)):
            return lhsUser == rhsUser
        case (.load, .load), (.delete, .delete):
            return true
        default:
            return false
        }
    }
}

final class LocalUserDataSpy: ILocalUser {
    
    var currentUser: User?
    var requests: [LocalUserRequests] = []

    func save(_ user: User) {
        currentUser = user
        requests.append(.save(user))
    }

    func load() -> User? {
        requests.append(.load)
        return currentUser
    }
    
    func delete() {
        currentUser = nil
        requests.append(.delete)
    }
}
