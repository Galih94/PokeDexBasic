//
//  ILoginViewModel.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 29/07/25.
//

protocol ILoginViewModel {
    var onRegister: (() -> Void) { get set }
    func register(_ name: String)
}
