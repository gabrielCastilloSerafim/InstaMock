//
//  ProfilePresenter.swift
//  InstaMock
//
//  Created by Gabriel Castillo Serafim on 21/12/22.
//  
//

import Foundation

class ProfilePresenter  {
    
    // MARK: Properties
    weak var view: ProfileViewProtocol?
    var interactor: ProfileInteractorInputProtocol?
    var wireFrame: ProfileWireFrameProtocol?
    
}

extension ProfilePresenter: ProfilePresenterProtocol {

    // TODO: implement presenter methods
    func viewDidLoad() {
    }
    
    func logOutTapped() {
        
        interactor?.performUserLogOut()
    }
}

extension ProfilePresenter: ProfileInteractorOutputProtocol {
    
    // TODO: implement interactor output methods
    
    func didLogUserOut() {
        wireFrame?.goToLoginView(fromVC: view as! ProfileView)
    }
}
