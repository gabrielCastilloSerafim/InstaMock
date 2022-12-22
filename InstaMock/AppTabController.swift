//
//  AppTabController.swift
//  InstaMock
//
//  Created by Gabriel Castillo Serafim on 21/12/22.
//

import UIKit

class AppTabController {
    
    private var tabController: UITabBarController?
    
    func start(with tabBarController: UITabBarController) {
        
        self.tabController = tabBarController
        
        let feedNavController = FeedWireFrame.createFeedModule()
        feedNavController.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "newspaper"), selectedImage: UIImage(systemName: "newspaper.fill"))
        
        let profileNavController = ProfileWireFrame.createProfileModule()
        profileNavController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.circle"), selectedImage: UIImage(systemName: "person.circle.fill"))
        
        tabBarController.viewControllers = [feedNavController, profileNavController]
    }
}


