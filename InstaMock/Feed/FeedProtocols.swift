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
    
    func reloadTableView()
}

protocol FeedWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createFeedModule() -> UIViewController
    
    func showCreatePostView(fromVC: FeedView, feedDelegate: FeedPresenter)
}

protocol FeedPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: FeedViewProtocol? { get set }
    var interactor: FeedInteractorInputProtocol? { get set }
    var wireFrame: FeedWireFrameProtocol? { get set }
    var postsDataSource: [Post] { get set }
    
    func viewDidLoad()
    func addPostTapeed()
    func userPulledToRefresh()
    func likeTapped(forObjectAtIndex: Int, isDislike: Bool)
}

protocol FeedInteractorOutputProtocol: AnyObject {
// INTERACTOR -> PRESENTER
    
    func didGetPosts(postsObjects: [Post])
}

protocol FeedInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: FeedInteractorOutputProtocol? { get set }
    var localDatamanager: FeedLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: FeedRemoteDataManagerInputProtocol? { get set }
    
    func getPosts()
    func addLikeToPost(postID: String, isDislike: Bool)
}

protocol FeedDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol FeedRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: FeedRemoteDataManagerOutputProtocol? { get set }
    
    func bringAllPostsFromDatabase()
    func updatePostLikesInDatabase(postID: String, isDislike: Bool)
}

protocol FeedRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    
    func successfullyGotPosts(postObjects: [Post])
}

protocol FeedLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}

protocol CreateNewPostDelegate: AnyObject {
    // CREATEPOST -> FEEDPRESENTER
    
    func didCreatePost()
}
