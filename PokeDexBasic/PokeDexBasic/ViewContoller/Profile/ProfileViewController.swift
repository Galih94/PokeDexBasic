//
//  ProfileViewController.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 30/07/25.
//

import UIKit
import XLPagerTabStrip

final class ProfileViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    
    let viewModel: IProfileViewModel
    
    init(viewModel: IProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "ProfileViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = viewModel.getName()
    }
    
}

extension ProfileViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Profile")
    }
}
