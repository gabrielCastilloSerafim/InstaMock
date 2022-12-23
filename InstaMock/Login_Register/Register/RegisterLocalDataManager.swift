//
//  RegisterLocalDataManager.swift
//  InstaMock
//
//  Created by Gabriel Castillo Serafim on 21/12/22.
//  
//

import Foundation

class RegisterLocalDataManager:RegisterLocalDataManagerInputProtocol {
    
    func updateUserDefaultsLogInStatus() {
        UserDefaults.standard.setValue(true, forKey: "isLoggedIn")
    }
    
    func saveUserDataToDefaults(name: String, Email: String) {
        
        let defaults = UserDefaults.standard
        
        defaults.set(name, forKey: "userName")
        defaults.set(Email, forKey: "email")
    }
    
}
