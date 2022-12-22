//
//  ProfileInteractor.swift
//  InstaMock
//
//  Created by Gabriel Castillo Serafim on 21/12/22.
//  
//

import Foundation

class ProfileInteractor: ProfileInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: ProfileInteractorOutputProtocol?
    var localDatamanager: ProfileLocalDataManagerInputProtocol?
    var remoteDatamanager: ProfileRemoteDataManagerInputProtocol?

}

extension ProfileInteractor: ProfileRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}
