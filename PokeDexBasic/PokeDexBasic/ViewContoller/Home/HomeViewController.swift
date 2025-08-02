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

final class HomeViewController: BaseViewController {
    
    @IBOutlet weak var searchContainerView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var viewModel: IHomeViewModel
    
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
        setupSearch()
        bindTableView()
        bindError()
        viewModel.loadPage()
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "PokemonTableViewCell", bundle: nil), forCellReuseIdentifier: "PokemonTableViewCell")
        tableView.tableFooterView = makeLoadingFooterView()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupSearch() {
        searchContainerView.layer.cornerRadius = 8
        
        searchTextField.enablesReturnKeyAutomatically = true
        searchTextField.delegate = self
        
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.tintColor = .white
        searchButton.layer.cornerRadius = 8
    }
    
    private func bindTableView() {
        viewModel.pokemons
            .asDriver()
            .drive(onNext: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        viewModel.isLoadingDetail
            .distinctUntilChanged()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] isLoading in
                guard let self, let isLoading else { return }
                self.showLoading(isLoading)
            })
            .disposed(by: disposeBag)
    }
    
    private func bindError() {
        viewModel.onSearchError = { [weak self] in
            guard let self else { return }
            self.showErrorAlert(message: "Pokemon Not Found", on: self)
        }
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        searchTextField.resignFirstResponder()
        guard let query = searchTextField.text, !query.isEmpty else { return }
        viewModel.searchPokemon(query)
    }
    
    func showErrorAlert(message: String, on viewController: UIViewController) {
        let alert = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        viewController.present(alert, animated: true)
    }

    func makeLoadingFooterView() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 60))
        
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.center = footerView.center
        activityIndicator.color = .white
        activityIndicator.startAnimating()
        
        footerView.addSubview(activityIndicator)
        
        return footerView
    }

}

extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let query = textField.text, !query.isEmpty else { return false }

        searchTextField.resignFirstResponder()
        viewModel.searchPokemon(query)

        return true
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
        cell.selectionStyle = .none
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.pokemons.value[indexPath.row]
        viewModel.onTappedPokemon?(item)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItemIndex = viewModel.pokemons.value.count - 1
        if indexPath.row == lastItemIndex {
            viewModel.loadPage()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 50
    }
}

extension HomeViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Home")
    }
}

