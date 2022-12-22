//
//  ProfileInteractor.swift
//  InstaMock
//
//  Created by Gabriel Castillo Serafim on 21/12/22.
//  
//

import Foundation
import FirebaseAuth

class ProfileInteractor: ProfileInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: ProfileInteractorOutputProtocol?
    var localDatamanager: ProfileLocalDataManagerInputProtocol?
    var remoteDatamanager: ProfileRemoteDataManagerInputProtocol?
    
    func performUserLogOut() {
        
        do {
            try FirebaseAuth.Auth.auth().signOut()
        } catch {
            print("Error signing out: \(error.localizedDescription)")
            return
        }
        localDatamanager?.changeUserDefaultsLoginStatus()
        presenter?.didLogUserOut()
    }
    

}

extension ProfileInteractor: ProfileRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}
