//
//  DetailViewController.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 31/07/25.
//

import MBProgressHUD
import Kingfisher
import RxSwift
import UIKit

final class DetailViewController: BaseViewController {
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var spriteImageView: UIImageView!
    
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
        bindView()
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
        viewModel.pokemonDetail
            .compactMap { $0 }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] value in
                self?.nameLabel.text = value.name
                self?.abilitiesLabel.text = value.abilities.joined(separator: ", ")
                if let url = URL(string: value.imageURL) {
                    self?.spriteImageView.kf.setImage(with: url)
                }
                
            })
            .disposed(by: disposeBag)
        
        viewModel.isLoading
            .distinctUntilChanged()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] isLoading in
                guard let self, let isLoading else { return }
                self.showLoading(isLoading)
            })
            .disposed(by: disposeBag)
    }
    
}
