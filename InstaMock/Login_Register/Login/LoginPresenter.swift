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
    
    func userTappedLogin(email: String?, password: String?) {

        if email != "", password != "" {
            interactor?.logUserIn(email: email!, passWord: password!)
        } else {
            view?.showMissingFieldAlert()
        }
        
    }
}

extension LoginPresenter: LoginInteractorOutputProtocol {
    
    // TODO: implement interactor output methods
    
    func didLogUserIn() {
        
        wireFrame?.goToTabBarController(fromVC: view as! LoginView)
    }
}
