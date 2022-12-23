//
//  FeedProtocols.swift
//  InstaMock
//
//  Created by Gabriel Castillo Serafim on 21/12/22.
//  
//

import Foundation
import UIKit

protocol FeedViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: FeedPresenterProtocol? { get set }
    
    func showImagePicker()
    func dismissImagePicker()
    func showSpinner()
    func dismissSpinner()
}

protocol FeedWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createFeedModule() -> UIViewController
}

protocol FeedPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: FeedViewProtocol? { get set }
    var interactor: FeedInteractorInputProtocol? { get set }
    var wireFrame: FeedWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func addPostTapeed()
    func userDidSelectImage(image: UIImage?)
    func userDidCancelImageSelection()
}

protocol FeedInteractorOutputProtocol: AnyObject {
// INTERACTOR -> PRESENTER
    
    func uploadedPost()
}

protocol FeedInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: FeedInteractorOutputProtocol? { get set }
    var localDatamanager: FeedLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: FeedRemoteDataManagerInputProtocol? { get set }
    
    func createPost(with image:UIImage)
}

protocol FeedDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol FeedRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: FeedRemoteDataManagerOutputProtocol? { get set }
    
    func uploadPost(image: UIImage, email: String, name: String, postID: String)
}

protocol FeedRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    
    func finishedUploadingPost()
}

protocol FeedLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
