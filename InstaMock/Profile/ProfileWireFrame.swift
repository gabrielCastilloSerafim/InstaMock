//
//  ProfileWireFrame.swift
//  InstaMock
//
//  Created by Gabriel Castillo Serafim on 21/12/22.
//  
//

import Foundation
import UIKit

class ProfileWireFrame: ProfileWireFrameProtocol {
    
    class func createProfileModule() -> UIViewController {
        
        let view = ProfileView()
        let navController = UINavigationController()
        navController.navigationBar.prefersLargeTitles = true
        navController.viewControllers = [view]
        
        let presenter: ProfilePresenterProtocol & ProfileInteractorOutputProtocol = ProfilePresenter()
        let interactor: ProfileInteractorInputProtocol & ProfileRemoteDataManagerOutputProtocol = ProfileInteractor()
        let localDataManager: ProfileLocalDataManagerInputProtocol = ProfileLocalDataManager()
        let remoteDataManager: ProfileRemoteDataManagerInputProtocol = ProfileRemoteDataManager()
        let wireFrame: ProfileWireFrameProtocol = ProfileWireFrame()
        
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.localDatamanager = localDataManager
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        
        return navController
    }
    
    
}
