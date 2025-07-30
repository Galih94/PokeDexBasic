//
//  MainTabViewController.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 30/07/25.
//

import UIKit
import XLPagerTabStrip

final class MainTabViewController: ButtonBarPagerTabStripViewController {

    let pages: [UIViewController]

    init(pages: [UIViewController]) {
        self.pages = pages
        super.init(nibName: nil, bundle: nil)
    }

    @MainActor required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Allow layout under status bar, but not under notch
        self.edgesForExtendedLayout = [.bottom]

        // Background color
        view.backgroundColor = .systemBackground
        containerView.backgroundColor = .systemBackground

        // Customize tab appearance
        settings.style.buttonBarBackgroundColor = .systemCyan
        settings.style.buttonBarItemBackgroundColor = .systemCyan
        settings.style.selectedBarBackgroundColor = .white
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        settings.style.selectedBarHeight = 0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .white
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        buttonBarView.selectedBar.backgroundColor = .white

        // Optional: remove nav bar if inside UINavigationController
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return pages
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        // Disable autoresizing masks
        buttonBarView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false

        // Remove previous constraints (optional safety)
        NSLayoutConstraint.deactivate(buttonBarView.constraints)
        NSLayoutConstraint.deactivate(containerView.constraints)

        // Reapply constraints using safe area
        NSLayoutConstraint.activate([
            // Tab bar (button bar)
            buttonBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            buttonBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buttonBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            buttonBarView.heightAnchor.constraint(equalToConstant: 44),

            // Container view (pages)
            containerView.topAnchor.constraint(equalTo: buttonBarView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}
