//
//  DetailViewController.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 31/07/25.
//

import UIKit

class DetailViewController: UIViewController {

    let viewModel: IDetailViewModel
    
    init(viewModel: IDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "DetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented. Use init(viewModel:) instead.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}
