//
//  FeedWireFrame.swift
//  InstaMock
//
//  Created by Gabriel Castillo Serafim on 21/12/22.
//  
//

import Foundation
import UIKit

class FeedWireFrame: FeedWireFrameProtocol {
    
    class func createFeedModule() -> UIViewController {
        
        let view = FeedView()
        let navController = UINavigationController()
        navController.navigationBar.prefersLargeTitles = true
        navController.viewControllers = [view]
        
        let presenter: FeedPresenterProtocol & FeedInteractorOutputProtocol = FeedPresenter()
        let interactor: FeedInteractorInputProtocol & FeedRemoteDataManagerOutputProtocol = FeedInteractor()
        let localDataManager: FeedLocalDataManagerInputProtocol = FeedLocalDataManager()
        let remoteDataManager: FeedRemoteDataManagerInputProtocol = FeedRemoteDataManager()
        let wireFrame: FeedWireFrameProtocol = FeedWireFrame()
        
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
    
    func showCreatePostView(fromVC: FeedView, feedDelegate: FeedPresenter) {
        
        let createViewVC = CreatePostWireFrame.createCreatePostModule(feedDelegate: feedDelegate)
        
        fromVC.present(createViewVC, animated: true)
    }
}
