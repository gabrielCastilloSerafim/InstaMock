//
//  LoginRemoteDataManager.swift
//  InstaMock
//
//  Created by Gabriel Castillo Serafim on 21/12/22.
//  
//

import Foundation
import FirebaseDatabase

class LoginRemoteDataManager:LoginRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: LoginRemoteDataManagerOutputProtocol?
    private let database = FirebaseDatabase.Database.database().reference()
    
    func getUserPersonalInfo(for email: String) {
        
        let formattedEmail = email.formatted
        
        database.child("\(formattedEmail)").getData { [weak self] error, snapshot in
            
            guard error == nil else { print("Error reading userInfo from Firebase DB \(error!.localizedDescription)"); return }
            
            guard let dict = snapshot?.value as? [String: Any] else { print("Error casting snapshot to dict \(error!.localizedDescription)"); return }
            
            guard let email = dict["email"] as? String,
                  let name = dict["name"] as? String
            else {
                print("Error casting snapShot value to String")
                return
            }
            
            self?.remoteRequestHandler?.receivedUserInfo(name: name, email: email)
        }
    }
}
