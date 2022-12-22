//
//  LoginWireFrame.swift
//  InstaMock
//
//  Created by Gabriel Castillo Serafim on 21/12/22.
//  
//

import Foundation
import UIKit

class LoginWireFrame: LoginWireFrameProtocol {
    
    class func createLoginModule() -> UIViewController {
        
        let view = LoginView()
        let presenter: LoginPresenterProtocol & LoginInteractorOutputProtocol = LoginPresenter()
        let interactor: LoginInteractorInputProtocol & LoginRemoteDataManagerOutputProtocol = LoginInteractor()
        let localDataManager: LoginLocalDataManagerInputProtocol = LoginLocalDataManager()
        let remoteDataManager: LoginRemoteDataManagerInputProtocol = LoginRemoteDataManager()
        let wireFrame: LoginWireFrameProtocol = LoginWireFrame()
        
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.localDatamanager = localDataManager
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        
        return view
    }
    
}
