//
//  CreatePostPresenter.swift
//  InstaMock
//
//  Created by Gabriel Castillo Serafim on 28/12/22.
//  
//

import UIKit

class CreatePostPresenter  {
    
    // MARK: Properties
    weak var view: CreatePostViewProtocol?
    var interactor: CreatePostInteractorInputProtocol?
    var wireFrame: CreatePostWireFrameProtocol?
    
}

extension CreatePostPresenter: CreatePostPresenterProtocol {
    // TODO: implement presenter methods
    func viewDidLoad() {
    }
    
    func imageGotTapped() {
        view?.presentActionSheet()
    }
    
    func userSelectedAlbum() {
        view?.presentImagePicker()
    }
    
    func userSelectedCamera() {
        view?.presentCamera()
    }
    
    func userSelectedImage(selectedImage: UIImage?) {
        guard let image = selectedImage else { print("Error receiving selectedImage"); return }
        
        view?.putSelectedImageInImageView(selectedImage: image)
        view?.dismissImagePicker()
    }
    
    func userTappedPostButton(selectedImage: UIImage, caption: String?) {
        if caption == "" || caption == nil {
            view?.showEmptyCaptionAlert()
            return
        } else {
            view?.showSpinner()
            interactor?.createPostObject(image: selectedImage, caption: caption!)
        }
    }
    
    
}

extension CreatePostPresenter: CreatePostInteractorOutputProtocol {
    // TODO: implement interactor output methods
    
    func dismissView() {
        wireFrame?.dismissTheCreatePostsView(fromVC: view as! CreatePostView)
        view?.hideSpinner()
    }
}
