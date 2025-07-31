//
//  DetailComposer.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 31/07/25.
//

enum DetailComposer {
    static func compose() -> DetailViewController {
        let viewModel = DetailViewModel()
        let viewController = DetailViewController(viewModel: viewModel)
        
        return viewController
    }
}

