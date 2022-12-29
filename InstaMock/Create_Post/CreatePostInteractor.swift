//
//  CreatePostInteractor.swift
//  InstaMock
//
//  Created by Gabriel Castillo Serafim on 28/12/22.
//  
//

import UIKit

class CreatePostInteractor: CreatePostInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: CreatePostInteractorOutputProtocol?
    var localDatamanager: CreatePostLocalDataManagerInputProtocol?
    var remoteDatamanager: CreatePostRemoteDataManagerInputProtocol?
    
    func createPostObject(image: UIImage, caption: String) {
        
        guard let creatorName = UserDefaults.standard.value(forKey: "userName") as? String else { print("Error getting userName from userDefaults"); return }
        guard let creatorEmail = UserDefaults.standard.value(forKey: "email") as? String else { print("Error getting email from userDefaults"); return }
        let creationTimeSince1970 = Date().timeIntervalSince1970
        let postID = "post_\(creatorName.formatted)_\(String(creationTimeSince1970).formatted)"
        let ImageID = "post_\(creatorName.formatted)_\(String(creationTimeSince1970).formatted).png"
        
        let postObject = Post(creatorName: creatorName,
                              creatorEmail: creatorEmail,
                              creationTimeSince1970: creationTimeSince1970,
                              postID: postID,
                              postImageID: ImageID,
                              postImageURL: nil,
                              postImage: image,
                              postCaption: caption,
                              numberOfLikes: 0,
                              creatorProfilePictureURL: nil)
        
        remoteDatamanager?.uploadPost(postObject: postObject)
    }
    
    
    
}

extension CreatePostInteractor: CreatePostRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
    
    func successUploadingPost() {
        presenter?.dismissView()
    }
}
