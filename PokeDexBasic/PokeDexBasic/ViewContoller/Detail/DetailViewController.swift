//
//  DetailViewController.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 31/07/25.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
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
        print("Navigation controller is: \(self.navigationController)")

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        if let nav = self.navigationController {
            print("Stack count: \(nav.viewControllers.count)")
            print("Current VC: \(self)")
            print("Stack: \(nav.viewControllers)")
        }

        viewModel.onBackTapped?()
    }
    
}
