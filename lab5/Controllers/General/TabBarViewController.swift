//
//  TabBarViewController.swift
//  lab5
//
//  Created by Sarvar Saidazov on 28.03.2024.
//

import UIKit

class TabBarViewController: UITabBarController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeIcon = MainViewController()
        let libraryIcon = LibraryViewController()
        let searchIcon = ExploreViewController()
        
        homeIcon.title = "Home"
        libraryIcon.title = "Library"
        searchIcon.title = "Explore"
        
        
        homeIcon.navigationItem.largeTitleDisplayMode = .always
        libraryIcon.navigationItem.largeTitleDisplayMode = .always
        searchIcon.navigationItem.largeTitleDisplayMode = .always
        
        let nav1 = UINavigationController(rootViewController: homeIcon)
        let nav2 = UINavigationController(rootViewController: libraryIcon)
        let nav3 = UINavigationController(rootViewController: searchIcon)
        
        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        nav3.navigationBar.prefersLargeTitles = true
        
        nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "books.vertical.fill"), tag: 1)
        nav3.tabBarItem = UITabBarItem(title: "Explore", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        
        setViewControllers([nav1,nav2,nav3], animated: false)
        
        tabBar.backgroundColor = UIColor.lightGray
        tabBar.barTintColor = UIColor.green
        
    
        
        
    }
    

    

}
