//
//  RegisterInteractor.swift
//  InstaMock
//
//  Created by Gabriel Castillo Serafim on 21/12/22.
//  
//

import UIKit
import FirebaseAuth

class RegisterInteractor: RegisterInteractorInputProtocol {
    
    // MARK: Properties
    weak var presenter: RegisterInteractorOutputProtocol?
    var localDatamanager: RegisterLocalDataManagerInputProtocol?
    var remoteDatamanager: RegisterRemoteDataManagerInputProtocol?
    
    func registerUser(with name: String, _ email: String, _ passWord: String, _ profileImage: UIImage) {
        
        //Create user account
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: passWord) { [weak self] _, error in
            
            guard error == nil else { print("Error in registration: \(error!.localizedDescription)"); return }
            
            self?.localDatamanager?.updateUserDefaultsLogInStatus()
            self?.localDatamanager?.saveUserDataToDefaults(name: name, Email: email)
            self?.remoteDatamanager?.createUserInFirebase(image: profileImage, email: email, name: name)
        }
    }
}

extension RegisterInteractor: RegisterRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
    
    func finishedUploadingUserPhoto() {
        presenter?.goToTabController()
    }
}
