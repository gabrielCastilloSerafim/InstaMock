//
//  FeedInteractor.swift
//  InstaMock
//
//  Created by Gabriel Castillo Serafim on 21/12/22.
//  
//

import Foundation

class FeedInteractor: FeedInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: FeedInteractorOutputProtocol?
    var localDatamanager: FeedLocalDataManagerInputProtocol?
    var remoteDatamanager: FeedRemoteDataManagerInputProtocol?
    
    func getPosts() {
        remoteDatamanager?.bringAllPostsFromDatabase()
    }
    
    func addLikeToPost(postID: String, isDislike: Bool) {
        remoteDatamanager?.updatePostLikesInDatabase(postID: postID, isDislike: isDislike)
    }
    
}

extension FeedInteractor: FeedRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
    
    func successfullyGotPosts(postObjects: [Post]) {
        presenter?.didGetPosts(postsObjects: postObjects)
    }
}
