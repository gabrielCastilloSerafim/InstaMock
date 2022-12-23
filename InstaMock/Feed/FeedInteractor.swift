//
//  FeedInteractor.swift
//  InstaMock
//
//  Created by Gabriel Castillo Serafim on 21/12/22.
//  
//

import UIKit

class FeedInteractor: FeedInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: FeedInteractorOutputProtocol?
    var localDatamanager: FeedLocalDataManagerInputProtocol?
    var remoteDatamanager: FeedRemoteDataManagerInputProtocol?
    
    func createPost(with image: UIImage) {
        
        guard let userEmail = UserDefaults.standard.value(forKey: "email") as? String else { print("Error getting data from userDefaults"); return }
        guard let name = UserDefaults.standard.value(forKey: "userName") as? String else { print("Error getting data from userDefaults"); return }
        let randomNumber = Date().timeIntervalSince1970
        let postID = "post_\(userEmail)_\(randomNumber)".formatted
        
        remoteDatamanager?.uploadPost(image: image, email: userEmail, name: name, postID: postID)
    }

}

extension FeedInteractor: FeedRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
    
    func finishedUploadingPost() {
        presenter?.uploadedPost()
    }
}
