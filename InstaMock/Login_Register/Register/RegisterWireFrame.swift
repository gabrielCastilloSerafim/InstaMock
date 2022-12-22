//
//  RegisterWireFrame.swift
//  InstaMock
//
//  Created by Gabriel Castillo Serafim on 21/12/22.
//  
//

import Foundation
import UIKit

class RegisterWireFrame: RegisterWireFrameProtocol {
    
    class func createRegisterModule() -> UIViewController {
        
        let view = RegisterView()
        let presenter: RegisterPresenterProtocol & RegisterInteractorOutputProtocol = RegisterPresenter()
        let interactor: RegisterInteractorInputProtocol & RegisterRemoteDataManagerOutputProtocol = RegisterInteractor()
        let localDataManager: RegisterLocalDataManagerInputProtocol = RegisterLocalDataManager()
        let remoteDataManager: RegisterRemoteDataManagerInputProtocol = RegisterRemoteDataManager()
        let wireFrame: RegisterWireFrameProtocol = RegisterWireFrame()
        
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
    
    func goToTabController(fromVC: RegisterView) {
        
        let tabBarController = UITabBarController()
        let appTabController = AppTabController()
        appTabController.start(with: tabBarController)
        
        tabBarController.modalPresentationStyle = .fullScreen
        fromVC.present(tabBarController, animated: false)
    }
}
