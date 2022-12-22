//
//  RegisterPresenter.swift
//  InstaMock
//
//  Created by Gabriel Castillo Serafim on 21/12/22.
//  
//

import UIKit

class RegisterPresenter  {
    
    // MARK: Properties
    weak var view: RegisterViewProtocol?
    var interactor: RegisterInteractorInputProtocol?
    var wireFrame: RegisterWireFrameProtocol?
    
}

extension RegisterPresenter: RegisterPresenterProtocol {

    // TODO: implement presenter methods
    func viewDidLoad() {
    }
    
    func registerButtonPressed(name: String?, email:String?, password: String?, profileImage: UIImage?) {
        
        if name != "", email != "", password != "", profileImage != nil {
            interactor?.registerUser(with: name!, email!, password!, profileImage!)
            view?.showSpinner()
        } else {
            view?.showAlert()
            return
        }
    }
    
    func profilePictureTapped() {
        view?.presentImagePickerController()
    }
    
    func userSelectedImage(image: UIImage?) {
        
        guard let image = image else { print("Error in selected image"); return }
        
        view?.placeSelectedImageInProfileImageView(image: image)
        view?.dismissImagePicker()
    }
    
    func userCancelledImagePicker() {
        view?.dismissImagePicker()
    }
}

extension RegisterPresenter: RegisterInteractorOutputProtocol {
    // TODO: implement interactor output methods
    
    func goToTabController() {
        wireFrame?.goToTabController(fromVC: view as! RegisterView)
        view?.hideSpinner()
    }
}
