//
//  Login_RegisterWireFrame.swift
//  InstaMock
//
//  Created by Gabriel Castillo Serafim on 21/12/22.
//  
//

import Foundation
import UIKit

class Login_RegisterWireFrame: Login_RegisterWireFrameProtocol {
    
    class func createLogin_RegisterModule() -> UIViewController {
        
        let navController = UINavigationController()
        
        let view = Login_RegisterView()
        navController.viewControllers = [view]
        
        let presenter: Login_RegisterPresenterProtocol & Login_RegisterInteractorOutputProtocol = Login_RegisterPresenter()
        let interactor: Login_RegisterInteractorInputProtocol = Login_RegisterInteractor()
        let wireFrame: Login_RegisterWireFrameProtocol = Login_RegisterWireFrame()
        
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return navController 
    }
    
    func pushLoginView(fromVC: Login_RegisterView) {
        
        let loginVC = LoginWireFrame.createLoginModule()
        
        fromVC.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    func pushRegisterView(fromVC: Login_RegisterView) {
        
        let registerVC = RegisterWireFrame.createRegisterModule()
        
        fromVC.navigationController?.pushViewController(registerVC, animated: true)
    }
    
}
