//
//  DetailViewModel.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 31/07/25.
//

protocol IDetailViewModel {
    var onBackTapped: (() -> Void)? { get set }
}

final class DetailViewModel: IDetailViewModel {
    var onBackTapped: (() -> Void)?
    
    init(onBackTapped: (() -> Void)?) {
        self.onBackTapped = onBackTapped
    }
}
