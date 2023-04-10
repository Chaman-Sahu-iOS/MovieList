//
//  MainTabBarController.swift
//  Movie Management
//
//  Created by chaman-8419 on 11/04/23.
//

import UIKit

class MainTabBarController: TabBarController, UITabBarControllerDelegate, UIViewControllerTransitioningDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createTabItems()
    }
    
    func createTabItems() {
        
       // setTabBarAppearance()
        self.tabBar.isTranslucent = false
        self.tabBar.barTintColor = .gray
        self.tabBar.tintColor = .blue
        self.tabBar.unselectedItemTintColor = .darkText
        
        let vc1 = MovieListController()
        vc1.sortBy = "Movie"
        
        let vc2 = MovieListController()
        vc2.sortBy = "Latest"
        
        let vc3 = MovieListController()
        vc3.sortBy = "Popular"
        
        let movieListController = UINavigationController(rootViewController: vc1)
        let latestMovieListController = UINavigationController(rootViewController: vc2)
        let popularMovieListController = UINavigationController(rootViewController: vc3)
        
        let movieTabItem = UITabBarItem(title: "Movie", image: UIImage(named: "add_watchlist")?.withRenderingMode(.alwaysTemplate), selectedImage: UIImage(named: "add_watchlist"))
        
        let latestTabItem = UITabBarItem(title: "Latest", image: UIImage(named: "add_watchlist")?.withRenderingMode(.alwaysTemplate), selectedImage: UIImage(named: "add_watchlist"))
        
        let popularTabItem = UITabBarItem(title: "Popular", image: UIImage(named: "add_watchlist")?.withRenderingMode(.alwaysTemplate), selectedImage: UIImage(named: "add_watchlist"))
        
        movieListController.tabBarItem              =   movieTabItem
        latestMovieListController.tabBarItem        =   latestTabItem
        popularMovieListController.tabBarItem       =   popularTabItem
        
        var tabControllers: [UIViewController] = [movieListController, latestMovieListController, popularMovieListController]
        
        
        self.viewControllers = tabControllers
    }
}
