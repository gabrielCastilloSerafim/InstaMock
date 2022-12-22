//
//  AppCoordinator.swift
//  InstaMock
//
//  Created by Gabriel Castillo Serafim on 21/12/22.
//

import UIKit

class AppCoordinator {
    
    func firstScreen() -> UIViewController {
        
        let defaults = UserDefaults.standard
        
        //defaults.set(nil, forKey: "isLoggedIn")
        
        if defaults.value(forKey: "isLoggedIn") == nil {
            
            //User is not logged in, show log in flow
            let loginRegisterScreen = Login_RegisterWireFrame.createLogin_RegisterModule()
            
            return loginRegisterScreen
        } else {
            //User is logged in show tab controller
            let tabBarController = UITabBarController()
            let appTabController = AppTabController()
            appTabController.start(with: tabBarController)
            
            return tabBarController
        }
    }
    
}
