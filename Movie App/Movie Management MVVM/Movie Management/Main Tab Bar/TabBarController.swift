//
//  TabBarController.swift
//  Movie Management
//
//  Created by chaman-8419 on 11/04/23.
//

import UIKit

class TabBarController: UITabBarController {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.setNavBarAppearance()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setNavBarAppearance() {
        // UITabBar
        
        if #available(iOS 15.0, *) {
           let appearance = UITabBarAppearance()
           appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .gray
            
            let tabFont =  UIFont.systemFont(ofSize:12)
            
           let normalAttributes     =   [NSAttributedString.Key.font: tabFont,
                                         NSAttributedString.Key.foregroundColor: UIColor.darkText]
           let selectedAttributes   =   [NSAttributedString.Key.font: tabFont,
                                         NSAttributedString.Key.foregroundColor: UIColor.blue]
                    
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = normalAttributes
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedAttributes
                    
            appearance.inlineLayoutAppearance.normal.titleTextAttributes = normalAttributes
            appearance.inlineLayoutAppearance.selected.titleTextAttributes = selectedAttributes

            appearance.compactInlineLayoutAppearance.normal.titleTextAttributes = normalAttributes
            appearance.compactInlineLayoutAppearance.selected.titleTextAttributes = selectedAttributes
           
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
        
        // UITabBarItem
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize:12), NSAttributedString.Key.foregroundColor: UIColor.darkText], for: [.normal])
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize:12), NSAttributedString.Key.foregroundColor:UIColor.blue], for: [.selected])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

