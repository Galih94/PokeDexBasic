//
//  DetailComposer.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 31/07/25.
//

enum DetailComposer {
    static func compose(onBackTapped: @escaping () -> Void) -> DetailViewController {
        let viewModel = DetailViewModel(onBackTapped: onBackTapped)
        let viewController = DetailViewController(viewModel: viewModel)
        
        return viewController
    }
}

