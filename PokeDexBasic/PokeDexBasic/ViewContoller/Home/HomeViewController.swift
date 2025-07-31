//
//  HomeViewController.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 30/07/25.
//

import UIKit
import RxSwift
import RxCocoa
import XLPagerTabStrip

final class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let viewModel: IHomeViewModel
    private let disposeBag = DisposeBag()
    
    init(viewModel: IHomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "HomeViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented. Use init(viewModel:) instead.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindTableView()
        viewModel.loadMoreIfNeeded()
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "PokemonTableViewCell", bundle: nil), forCellReuseIdentifier: "PokemonTableViewCell")
        tableView.dataSource = self
    }
    
    private func bindTableView() {
        viewModel.pokemons
            .asDriver()
            .drive(onNext: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        tableView.rx.contentOffset
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] offset in
                guard let self = self else { return }
                let y = offset.y
                let threshold = tableView.contentSize.height - tableView.frame.size.height
                if y > threshold - 100 {
                    self.viewModel.loadMoreIfNeeded()
                }
            })
            .disposed(by: disposeBag)
    }
}


extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pokemons.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let item = viewModel.pokemons.value[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonTableViewCell", for: indexPath) as? PokemonTableViewCell else { return UITableViewCell() }

        cell.nameLabel.text = item.name
        return cell
    }
}


extension HomeViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Home")
    }
}

