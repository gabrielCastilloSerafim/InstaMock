//
//  Login_RegisterProtocols.swift
//  InstaMock
//
//  Created by Gabriel Castillo Serafim on 21/12/22.
//  
//

import Foundation
import UIKit

protocol Login_RegisterViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: Login_RegisterPresenterProtocol? { get set }
}

protocol Login_RegisterWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createLogin_RegisterModule() -> UIViewController
    
    func pushLoginView(fromVC: Login_RegisterView)
    func pushRegisterView(fromVC: Login_RegisterView)
}

protocol Login_RegisterPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: Login_RegisterViewProtocol? { get set }
    var interactor: Login_RegisterInteractorInputProtocol? { get set }
    var wireFrame: Login_RegisterWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func loginTapped(fromVC: Login_RegisterView)
    func registerTapped(fromVC: Login_RegisterView)
}

protocol Login_RegisterInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
}

protocol Login_RegisterInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: Login_RegisterInteractorOutputProtocol? { get set }
}
