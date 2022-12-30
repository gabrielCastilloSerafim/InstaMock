//
//  FeedPresenter.swift
//  InstaMock
//
//  Created by Gabriel Castillo Serafim on 21/12/22.
//  
//

import UIKit

class FeedPresenter: CreateNewPostDelegate  {
    
    // MARK: Properties
    weak var view: FeedViewProtocol?
    var interactor: FeedInteractorInputProtocol?
    var wireFrame: FeedWireFrameProtocol?
    var postsDataSource = [Post]()
    
    //Gets called in the create view thru protocol deleagte when post gets done uploading
    func didCreatePost() {
        interactor?.getPosts()
    }
    
    
}

extension FeedPresenter: FeedPresenterProtocol {
    // TODO: implement presenter methods
    
    func viewDidLoad() {
        view?.showSkeletonView()
        interactor?.getPosts()
    }
    
    func addPostTapeed() {
        wireFrame?.showCreatePostView(fromVC: view as! FeedView, feedDelegate: self)
    }
    
    func userPulledToRefresh() {
        interactor?.getPosts()
    }
    
    func likeTapped(forObjectAtIndex: Int, isDislike: Bool) {
        let postID = postsDataSource[forObjectAtIndex].postID
        interactor?.addLikeToPost(postID: postID, isDislike: isDislike)
    }
    
}

extension FeedPresenter: FeedInteractorOutputProtocol {
    // TODO: implement interactor output methods
    
    func didGetPosts(postsObjects: [Post]) {
        postsDataSource = postsObjects
        view?.reloadTableView()
        view?.hideSkeletonView()
    }
    
}
