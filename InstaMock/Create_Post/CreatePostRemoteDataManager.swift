//
//  CreatePostRemoteDataManager.swift
//  InstaMock
//
//  Created by Gabriel Castillo Serafim on 28/12/22.
//  
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

class CreatePostRemoteDataManager:CreatePostRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: CreatePostRemoteDataManagerOutputProtocol?
    private let database = FirebaseDatabase.Database.database().reference()
    private let storage = FirebaseStorage.Storage.storage().reference()
    
    func uploadPost(postObject: Post) {
        //Upload image to fireStore
        guard let imageData = postObject.postImage?.pngData() else { print("Error getting postImagePNGData"); return }
        storage.child("images/\(postObject.postImageID!)").putData(imageData) { [weak self]  _, error in
            guard error == nil else { print("Error uploading media"); return }
            
            //Get the uploaded image's URL
            self?.storage.child("images/\(postObject.postImageID!)").downloadURL { url, error in
                guard let postImageURL = url?.absoluteString else { print("Error getting url for uploaded post"); return }
                
                //Get the creator's profilePicture downloadURL
                self?.database.child("\(postObject.creatorEmail.formatted)/profileImageDownloadURL").getData(completion: { error, snapshot in
                    guard let creatorProfilePictureURL = snapshot?.value as? String else { print("Error getting the creatorProfilePictureURLDict"); return }
                    
                    //add post to postsNode
                    let postDict: [String: Any] = ["creatorName": postObject.creatorName,
                                                   "creatorEmail": postObject.creatorEmail,
                                                   "creationTimeSince1970": postObject.creationTimeSince1970,
                                                   "postID": postObject.postID,
                                                   "postImageID": postObject.postImageID!,
                                                   "postImageURL": postImageURL,
                                                   "postCaption": postObject.postCaption,
                                                   "numberOfLikes": postObject.numberOfLikes,
                                                   "creatorProfilePictureURL": creatorProfilePictureURL
                    ]
                    self?.database.child("posts/\(postObject.postID)").updateChildValues(postDict, withCompletionBlock: { error, _ in
                        guard error == nil else { print("Error uploading post object to database"); return }
                        
                        //Set post id to user's posts node
                        let postIDDict = [postObject.postID: postObject.postID]
                        self?.database.child("\(postObject.creatorEmail.formatted)/posts").updateChildValues(postIDDict, withCompletionBlock: { error, _ in
                            guard error == nil else { print("Error uploading postID to user's posts node"); return }
                            
                            self?.remoteRequestHandler?.successUploadingPost()
                        })
                    })
                })
            }
        }
    }
    
    
    
}
