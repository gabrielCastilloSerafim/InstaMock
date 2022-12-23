//
//  FeedRemoteDataManager.swift
//  InstaMock
//
//  Created by Gabriel Castillo Serafim on 21/12/22.
//  
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

class FeedRemoteDataManager:FeedRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: FeedRemoteDataManagerOutputProtocol?
    private let database = FirebaseDatabase.Database.database().reference()
    private let storage = FirebaseStorage.Storage.storage().reference()
    
    func uploadPost(image: UIImage, email: String, name: String, postID: String) {
        
        //Upload image to fireStore
        guard let imageData = image.pngData() else { print("Error getting post image png data"); return }
        storage.child("images/\(postID).png").putData(imageData) { [weak self] _ in
            
            //Get uploaded image's download url
            self?.storage.child("images/\(postID).png").downloadURL { url, error in
                guard let url = url?.absoluteString else { print("error getting post image download URL"); return }
                
                //Write post info to fireStore database
                let postDict = ["postID":postID, "name":name, "email":email, "imageDownloadURL":url]
                self?.database.child("posts/\(postID)").setValue(postDict) { error, _ in
                    guard error == nil else { print("Error saving post info to database"); return }
                    self?.remoteRequestHandler?.finishedUploadingPost()
                }
            }
        }
    }
    
    
}
