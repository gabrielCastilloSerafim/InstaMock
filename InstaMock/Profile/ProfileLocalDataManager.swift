//
//  ProfileLocalDataManager.swift
//  InstaMock
//
//  Created by Gabriel Castillo Serafim on 21/12/22.
//  
//

import Foundation

class ProfileLocalDataManager:ProfileLocalDataManagerInputProtocol {
    
    func changeUserDefaultsLoginStatus() {
        
        UserDefaults.standard.set(nil, forKey: "isLoggedIn")
    }
    
}
