//
//  LoginViewController.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 29/07/25.
//

import UIKit

public final class LoginViewController: UIViewController {

    let viewModel: ILoginViewModel
    
    init(viewModel: ILoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "LoginViewController", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented. Use init(viewModel:) instead.")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
