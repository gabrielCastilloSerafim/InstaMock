//
//  Login_RegisterPresenter.swift
//  InstaMock
//
//  Created by Gabriel Castillo Serafim on 21/12/22.
//  
//

import Foundation

class Login_RegisterPresenter  {
    
    // MARK: Properties
    weak var view: Login_RegisterViewProtocol?
    var interactor: Login_RegisterInteractorInputProtocol?
    var wireFrame: Login_RegisterWireFrameProtocol?
    
}

extension Login_RegisterPresenter: Login_RegisterPresenterProtocol {
    // TODO: implement presenter methods
    func viewDidLoad() {
    }
    
    func loginTapped(fromVC: Login_RegisterView) {
        wireFrame?.pushLoginView(fromVC: fromVC)
    }
    
    func registerTapped(fromVC: Login_RegisterView) {
        wireFrame?.pushRegisterView(fromVC: fromVC)
    }
}

extension Login_RegisterPresenter: Login_RegisterInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
