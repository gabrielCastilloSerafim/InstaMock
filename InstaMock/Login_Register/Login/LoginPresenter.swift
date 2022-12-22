//
//  LoginPresenter.swift
//  InstaMock
//
//  Created by Gabriel Castillo Serafim on 21/12/22.
//  
//

import Foundation

class LoginPresenter  {
    
    // MARK: Properties
    weak var view: LoginViewProtocol?
    var interactor: LoginInteractorInputProtocol?
    var wireFrame: LoginWireFrameProtocol?
    
}

extension LoginPresenter: LoginPresenterProtocol {
    // TODO: implement presenter methods
    func viewDidLoad() {
    }
}

extension LoginPresenter: LoginInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
