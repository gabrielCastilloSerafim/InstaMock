//
//  ProfileProtocols.swift
//  InstaMock
//
//  Created by Gabriel Castillo Serafim on 21/12/22.
//  
//

import Foundation
import UIKit

protocol ProfileViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: ProfilePresenterProtocol? { get set }
    
    func populateView(profileObject: Profile)
    func showSkeletonView()
    func hideSkeletonView()
}

protocol ProfileWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createProfileModule() -> UIViewController
    
    func goToLoginView(fromVC: ProfileView)
}

protocol ProfilePresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: ProfileViewProtocol? { get set }
    var interactor: ProfileInteractorInputProtocol? { get set }
    var wireFrame: ProfileWireFrameProtocol? { get set }
    var imagesDataSource: [UIImage] { get set } 
    
    func viewDidLoad()
    func logOutTapped()
}

protocol ProfileInteractorOutputProtocol: AnyObject {
// INTERACTOR -> PRESENTER
    
    func didLogUserOut()
    func didReceiveProfileInfo(profileObject: Profile)
}

protocol ProfileInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: ProfileInteractorOutputProtocol? { get set }
    var localDatamanager: ProfileLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: ProfileRemoteDataManagerInputProtocol? { get set }
    
    func performUserLogOut()
    func getUserInfo()
}

protocol ProfileDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol ProfileRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: ProfileRemoteDataManagerOutputProtocol? { get set }
    
    func getUserInfoFromFirebase(for email: String)
}

protocol ProfileRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    
    func gotProfileObject(profileObject: Profile)
}

protocol ProfileLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
    
    func changeUserDefaultsLoginStatus()
}
