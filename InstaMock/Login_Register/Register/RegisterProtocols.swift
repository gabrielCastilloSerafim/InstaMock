//
//  RegisterProtocols.swift
//  InstaMock
//
//  Created by Gabriel Castillo Serafim on 21/12/22.
//  
//

import Foundation
import UIKit

protocol RegisterViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: RegisterPresenterProtocol? { get set }
    
    func showAlert()
    func showSpinner()
    func hideSpinner()
    func presentImagePickerController()
    func dismissImagePicker()
    func placeSelectedImageInProfileImageView(image: UIImage)
}

protocol RegisterWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createRegisterModule() -> UIViewController
    
    func goToTabController(fromVC: RegisterView)
}

protocol RegisterPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: RegisterViewProtocol? { get set }
    var interactor: RegisterInteractorInputProtocol? { get set }
    var wireFrame: RegisterWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func registerButtonPressed(name: String?, email:String?, password: String?, profileImage: UIImage?)
    func profilePictureTapped()
    func userSelectedImage(image: UIImage?)
    func userCancelledImagePicker()
}

protocol RegisterInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    
    func goToTabController()
}

protocol RegisterInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: RegisterInteractorOutputProtocol? { get set }
    var localDatamanager: RegisterLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: RegisterRemoteDataManagerInputProtocol? { get set }
    
    func registerUser(with name: String, _ email: String, _ passWord: String, _ profileImage: UIImage)
}

protocol RegisterDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
    
}

protocol RegisterRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: RegisterRemoteDataManagerOutputProtocol? { get set }
    
    func createUserInFirebase(image: UIImage, email: String, name:String)
}

protocol RegisterRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    
    func finishedUploadingUserPhoto()
}

protocol RegisterLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
    
    func updateUserDefaultsLogInStatus()
    func saveUserDataToDefaults(name: String, Email: String)
}
