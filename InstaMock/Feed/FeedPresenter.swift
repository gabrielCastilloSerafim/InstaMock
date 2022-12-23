//
//  FeedPresenter.swift
//  InstaMock
//
//  Created by Gabriel Castillo Serafim on 21/12/22.
//  
//

import UIKit

class FeedPresenter  {
    
    // MARK: Properties
    weak var view: FeedViewProtocol?
    var interactor: FeedInteractorInputProtocol?
    var wireFrame: FeedWireFrameProtocol?
    
}

extension FeedPresenter: FeedPresenterProtocol {
    // TODO: implement presenter methods
    func viewDidLoad() {
    }
    
    func addPostTapeed() {
        view?.showImagePicker()
    }
    
    func userDidSelectImage(image: UIImage?) {
        
        guard let image = image else { print("Error in selected image"); return }
        
        interactor?.createPost(with: image)
        view?.showSpinner()
    }
    
    func userDidCancelImageSelection() {
        view?.dismissImagePicker()
    }
}

extension FeedPresenter: FeedInteractorOutputProtocol {
    // TODO: implement interactor output methods
    
    func uploadedPost() {
        view?.dismissSpinner()
        view?.dismissImagePicker()
    }
}
