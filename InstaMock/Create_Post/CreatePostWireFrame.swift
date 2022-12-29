//
//  CreatePostWireFrame.swift
//  InstaMock
//
//  Created by Gabriel Castillo Serafim on 28/12/22.
//  
//

import Foundation
import UIKit

class CreatePostWireFrame: CreatePostWireFrameProtocol {
    
    class func createCreatePostModule() -> UIViewController {
        
        let view = CreatePostView()
        let presenter: CreatePostPresenterProtocol & CreatePostInteractorOutputProtocol = CreatePostPresenter()
        let interactor: CreatePostInteractorInputProtocol & CreatePostRemoteDataManagerOutputProtocol = CreatePostInteractor()
        let localDataManager: CreatePostLocalDataManagerInputProtocol = CreatePostLocalDataManager()
        let remoteDataManager: CreatePostRemoteDataManagerInputProtocol = CreatePostRemoteDataManager()
        let wireFrame: CreatePostWireFrameProtocol = CreatePostWireFrame()
        
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
    
    func dismissTheCreatePostsView(fromVC: CreatePostView) {
        
        fromVC.dismiss(animated: true)
    }
    
}
