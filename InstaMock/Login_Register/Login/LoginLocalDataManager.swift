//
//  LoginLocalDataManager.swift
//  InstaMock
//
//  Created by Gabriel Castillo Serafim on 21/12/22.
//  
//

import Foundation

class LoginLocalDataManager:LoginLocalDataManagerInputProtocol {
    
    
    func updateUserDefaultsLoginStatus() {
        
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
    }
    
    
}
