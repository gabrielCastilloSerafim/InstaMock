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
}

protocol FeedInteractorOutputProtocol: AnyObject {
// INTERACTOR -> PRESENTER
}

protocol FeedInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: FeedInteractorOutputProtocol? { get set }
    var localDatamanager: FeedLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: FeedRemoteDataManagerInputProtocol? { get set }
}

protocol FeedDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol FeedRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: FeedRemoteDataManagerOutputProtocol? { get set }
}

protocol FeedRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
}

protocol FeedLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
