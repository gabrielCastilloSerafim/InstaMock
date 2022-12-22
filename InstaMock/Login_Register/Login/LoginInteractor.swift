//
//  LoginInteractor.swift
//  InstaMock
//
//  Created by Gabriel Castillo Serafim on 21/12/22.
//  
//

import Foundation
import FirebaseAuth

class LoginInteractor: LoginInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: LoginInteractorOutputProtocol?
    var localDatamanager: LoginLocalDataManagerInputProtocol?
    var remoteDatamanager: LoginRemoteDataManagerInputProtocol?
    
    func logUserIn(email: String, passWord: String) {
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: passWord) { [weak self] _, error in
            
            guard error == nil else { print("Error in login: \(error!.localizedDescription)"); return }
            
            self?.localDatamanager?.updateUserDefaultsLoginStatus()
            self?.presenter?.didLogUserIn()
        }
    }
}

extension LoginInteractor: LoginRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}
