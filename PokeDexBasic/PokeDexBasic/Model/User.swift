//
//  User.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 29/07/25.
//

//import RealmSwift
//import Alamofire

public struct User: Equatable  {
    public let name: String
    
    public init(name: String) {
        self.name = name
    }
    
//    func testhere() {
//        AF.request("https://pokeapi.co/api/v2/pokemon").response { response in
//            print(response)
//        }
//    }
}
//
//class RealmUser: Object {
//    @Persisted var name: String = ""
//    
//    func map() -> User {
//        return User(name: name)
//    }
//}
