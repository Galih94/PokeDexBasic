//
//  LoginViewController.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 29/07/25.
//

import UIKit

public final class LoginViewController: UIViewController {

    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
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

        nameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        setRegisterButtonEnabled(false)
    }

    @IBAction func registerTapped(_ sender: Any) {
        viewModel.register(nameTextField.text ?? "")
    }
    
    func setRegisterButtonEnabled(_ enabled: Bool) {
        registerButton.isEnabled = enabled
        registerButton.alpha = enabled ? 1.0 : 0.5
    }
}

// Textfield delegate
extension LoginViewController {
    @objc private func textFieldDidChange(_ textField: UITextField) {
        let isEmpty = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true
        setRegisterButtonEnabled(!isEmpty)
    }

}
