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
}

protocol LoginWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createLoginModule() -> UIViewController
}

protocol LoginPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: LoginViewProtocol? { get set }
    var interactor: LoginInteractorInputProtocol? { get set }
    var wireFrame: LoginWireFrameProtocol? { get set }
    
    func viewDidLoad()
}

protocol LoginInteractorOutputProtocol: AnyObject {
// INTERACTOR -> PRESENTER
}

protocol LoginInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: LoginInteractorOutputProtocol? { get set }
    var localDatamanager: LoginLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: LoginRemoteDataManagerInputProtocol? { get set }
}

protocol LoginDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol LoginRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: LoginRemoteDataManagerOutputProtocol? { get set }
}

protocol LoginRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
}

protocol LoginLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
