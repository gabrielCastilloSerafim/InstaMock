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
    var postsDataSource = [Post]()
    
}

extension FeedPresenter: FeedPresenterProtocol {
    // TODO: implement presenter methods
    
    func viewDidLoad() {
        interactor?.getPosts()
    }
    
    func addPostTapeed() {
        wireFrame?.showCreatePostView(fromVC: view as! FeedView)
    }
    
}

extension FeedPresenter: FeedInteractorOutputProtocol {
    // TODO: implement interactor output methods
    
    func didGetPosts(postsObjects: [Post]) {
        postsDataSource = postsObjects
        view?.reloadTableView()
    }
    
}
