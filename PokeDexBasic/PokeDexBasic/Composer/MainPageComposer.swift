//
//  MainPageComposer.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 30/07/25.
//

enum MainPageComposer {
    static func compose() -> MainTabViewController {
        let profile = ProfileViewController()
        let home = HomeViewController()
        let mainTab = MainTabViewController(pages: [home, profile])
        
        return mainTab
    }
}
