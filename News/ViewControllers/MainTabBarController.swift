//
//  ViewController.swift
//  News
//
//  Created by Wimansha Chathuranga on 11/9/19.
//  Copyright © 2019 Wimansha. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewControllers()
    }
    
    func setupViewControllers() {
        let headlinesVc = self.templateNavController(title: "Headlines", rootViewController: HeadlinesViewController())
        let customNewsVc = self.templateNavController(title: "Custom News", rootViewController: CustomNewsViewController())
        let profileVc = self.templateNavController(title: "Profile", rootViewController: ProfileViewController())
        viewControllers = [headlinesVc,customNewsVc,profileVc]
    }
    
    private func templateNavController(title: String, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        let viewController = rootViewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        return navController
    }

}
