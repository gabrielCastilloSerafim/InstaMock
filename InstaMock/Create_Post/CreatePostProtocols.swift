//
//  CreatePostProtocols.swift
//  InstaMock
//
//  Created by Gabriel Castillo Serafim on 28/12/22.
//  
//

import Foundation
import UIKit

protocol CreatePostViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: CreatePostPresenterProtocol? { get set }
    
    func presentActionSheet()
    func presentImagePicker()
    func presentCamera()
    func putSelectedImageInImageView(selectedImage: UIImage)
    func dismissImagePicker()
    func showEmptyCaptionAlert()
    func showSpinner()
    func hideSpinner()
}

protocol CreatePostWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createCreatePostModule(feedDelegate: FeedPresenter) -> UIViewController
    
    func dismissTheCreatePostsView(fromVC: CreatePostView)
}

protocol CreatePostPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: CreatePostViewProtocol? { get set }
    var interactor: CreatePostInteractorInputProtocol? { get set }
    var wireFrame: CreatePostWireFrameProtocol? { get set }
    var feedDelegate: CreateNewPostDelegate? { get set }
    
    func viewDidLoad()
    func imageGotTapped()
    func userSelectedAlbum()
    func userSelectedCamera()
    func userSelectedImage(selectedImage: UIImage?)
    func userTappedPostButton(selectedImage: UIImage, caption: String?)
}

protocol CreatePostInteractorOutputProtocol: AnyObject {
// INTERACTOR -> PRESENTER
    
    func dismissView()
}

protocol CreatePostInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: CreatePostInteractorOutputProtocol? { get set }
    var localDatamanager: CreatePostLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: CreatePostRemoteDataManagerInputProtocol? { get set }
    
    func createPostObject(image: UIImage, caption: String)
}

protocol CreatePostDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol CreatePostRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: CreatePostRemoteDataManagerOutputProtocol? { get set }
    
    func uploadPost(postObject: Post)
}

protocol CreatePostRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    
    func successUploadingPost()
}

protocol CreatePostLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
