//
//  LoginProtocols.swift
//  InstaMock
//
//  Created by Gabriel Castillo Serafim on 21/12/22.
//  
//

import Foundation
import UIKit

protocol LoginViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: LoginPresenterProtocol? { get set }
    
    func showMissingFieldAlert()
}

protocol LoginWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createLoginModule() -> UIViewController
    
    func goToTabBarController(fromVC: LoginView)
}

protocol LoginPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: LoginViewProtocol? { get set }
    var interactor: LoginInteractorInputProtocol? { get set }
    var wireFrame: LoginWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func userTappedLogin(email: String?, password: String?)
}

protocol LoginInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    
    func didLogUserIn()
}

protocol LoginInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: LoginInteractorOutputProtocol? { get set }
    var localDatamanager: LoginLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: LoginRemoteDataManagerInputProtocol? { get set }
    
    func logUserIn(email: String, passWord: String)
}

protocol LoginDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol LoginRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: LoginRemoteDataManagerOutputProtocol? { get set }
    
    func getUserPersonalInfo(for email: String)
}

protocol LoginRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    
    func receivedUserInfo(name: String, email: String)
}

protocol LoginLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
    
    func updateUserDefaultsLoginStatus()
    func saveUserDataToDefaults(name: String, Email: String)
}
