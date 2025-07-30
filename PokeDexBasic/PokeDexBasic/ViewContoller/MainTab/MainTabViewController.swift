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
            // Must set styles before calling super.viewDidLoad()
            settings.style.buttonBarBackgroundColor = .systemCyan
            settings.style.buttonBarItemBackgroundColor = .systemCyan
            settings.style.selectedBarBackgroundColor = .white
            settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
            settings.style.selectedBarHeight = 3.0
            settings.style.buttonBarMinimumLineSpacing = 0
            settings.style.buttonBarItemsShouldFillAvailableWidth = true
            settings.style.buttonBarItemTitleColor = .white

            super.viewDidLoad()

            // Remove layout margins that might cause visual gap
            buttonBarView.layoutMargins = .zero
            buttonBarView.backgroundColor = .systemCyan
            buttonBarView.selectedBar.backgroundColor = .white

            // Set backgroundColor on all cells to prevent vertical lines
            changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, _, _, _) in
                oldCell?.backgroundColor = .systemCyan
                newCell?.backgroundColor = .systemCyan
                oldCell?.label.textColor = .white
                newCell?.label.textColor = .white
            }

            self.edgesForExtendedLayout = []
            self.view.backgroundColor = .white
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
