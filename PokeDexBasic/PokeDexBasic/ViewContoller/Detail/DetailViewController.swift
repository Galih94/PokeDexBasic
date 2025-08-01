//
//  DetailViewController.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 31/07/25.
//

import UIKit
import RxSwift

class DetailViewController: UIViewController {
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    private let disposeBag = DisposeBag()
    
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
        
        viewModel.loadDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        viewModel.onBackTapped?()
    }
    
    private func bindView() {
        viewModel.pokemonDetail?
            .subscribe(onNext: { [weak self] value in
                self?.nameLabel.text = value.name
                self?.abilitiesLabel.text = value.abilities.joined(separator: ", ")
            })
            .disposed(by: disposeBag)
    }
}
