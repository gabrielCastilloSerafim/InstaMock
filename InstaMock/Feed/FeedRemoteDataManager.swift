//
//  FeedRemoteDataManager.swift
//  InstaMock
//
//  Created by Gabriel Castillo Serafim on 21/12/22.
//  
//

import Foundation
import FirebaseDatabase

class FeedRemoteDataManager:FeedRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: FeedRemoteDataManagerOutputProtocol?
    private let database = FirebaseDatabase.Database.database().reference()
    
    func bringAllPostsFromDatabase() {
        
        database.child("posts").getData { [weak self] error, snapshot in
            guard let snapshotDicts = snapshot?.value as? [String: [String: Any]] else { print("Error getting posts snapshotDict"); return }
            
            var postObjectsArray = [Post]()
            
            for dict in snapshotDicts {
                guard let creationTimeSince1970 = dict.value["creationTimeSince1970"] as? Double,
                      let creatorEmail = dict.value["creatorEmail"] as? String,
                      let creatorName = dict.value["creatorName"] as? String,
                      let numberOfLikes = dict.value["numberOfLikes"] as? Int,
                      let postCaption = dict.value["postCaption"] as? String,
                      let postID = dict.value["postID"] as? String,
                      let postImageID = dict.value["postImageID"] as? String,
                      let postImageURL = dict.value["postImageURL"] as? String,
                      let creatorProfilePictureURL = dict.value["creatorProfilePictureURL"] as? String
                else { print("Error converting post object to dictionary"); return }
                
                let postObject = Post(creatorName: creatorName,
                                      creatorEmail: creatorEmail,
                                      creationTimeSince1970: creationTimeSince1970,
                                      postID: postID,
                                      postImageID: postImageID,
                                      postImageURL: postImageURL,
                                      postImage: nil,
                                      postCaption: postCaption,
                                      numberOfLikes: numberOfLikes,
                                      creatorProfilePictureURL: creatorProfilePictureURL)
                
                postObjectsArray.append(postObject)
            }
            let sortedPostObjectsArray = postObjectsArray.sorted { $0.creationTimeSince1970 > $1.creationTimeSince1970 }
            self?.remoteRequestHandler?.successfullyGotPosts(postObjects: sortedPostObjectsArray)
        }
    }
    
    func updatePostLikesInDatabase(postID: String, isDislike: Bool) {
        
        database.child("posts/\(postID)/numberOfLikes").getData { [weak self] error, snapshot in
            guard var numberOfLikes = snapshot?.value as? Int else { print("Error getting number of likes snapshot value"); return }
            
            //Add or subtract one to the number of likes that the post already have and upload the updated value to the database
            if isDislike == true {
                numberOfLikes -= 1
            } else {
                numberOfLikes += 1
            }
            
            self?.database.child("posts/\(postID)/numberOfLikes").setValue(numberOfLikes)
        }
    }
    
    
    
    
}
