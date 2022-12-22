//
//  LoginInteractor.swift
//  InstaMock
//
//  Created by Gabriel Castillo Serafim on 21/12/22.
//  
//

import Foundation

class LoginInteractor: LoginInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: LoginInteractorOutputProtocol?
    var localDatamanager: LoginLocalDataManagerInputProtocol?
    var remoteDatamanager: LoginRemoteDataManagerInputProtocol?

}

extension LoginInteractor: LoginRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}
