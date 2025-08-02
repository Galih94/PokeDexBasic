//
//  BaseViewController.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 02/08/25.
//


import MBProgressHUD
import RxSwift
import UIKit

class BaseViewController: UIViewController {
    let disposeBag = DisposeBag()
    func showLoading(_ isShow: Bool) {
        if isShow {
            let hud = MBProgressHUD.showAdded(to: view, animated: true)
            hud.label.text = "Loading..."
        } else {
            MBProgressHUD.hide(for: view, animated: true)
        }
    }
}
