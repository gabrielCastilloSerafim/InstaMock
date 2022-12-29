//
//  ProfileRemoteDataManager.swift
//  InstaMock
//
//  Created by Gabriel Castillo Serafim on 21/12/22.
//  
//

import Foundation
import FirebaseDatabase

class ProfileRemoteDataManager:ProfileRemoteDataManagerInputProtocol {

    var remoteRequestHandler: ProfileRemoteDataManagerOutputProtocol?
    private let database = FirebaseDatabase.Database.database().reference()
    
    func getUserInfoFromFirebase(for email: String) {
        
        database.child("\(email)").getData { [weak self] error, snapshot in
            guard let snapshotDict = snapshot?.value as? [String: Any] else { print("Error getting user snapshotDict"); return }
            
            //Get the user personal info
            guard let name = snapshotDict["name"] as? String,
                  let profileImageURL = snapshotDict["profileImageDownloadURL"] as? String
            else { print("Error extracting snapDictData"); return }
            
            //Check if user has uploaded posts
            if let postsDict = snapshotDict["posts"] as? [String: Any] {
                //If user has uploaded posts get an array with all the user's postsIDs from the postsDict
                var postsIDs = [String]()
                for item in postsDict {
                    postsIDs.append(item.value as! String)
                }
                
                //Get the imageURL for each post that the user has
                self?.database.child("posts").getData(completion: { error, snapshot in
                    guard let snapDict = snapshot?.value as? [String: [String: Any]] else { print("Error getting snapshot value as [String: [String: Any]]"); return }
                    
                    var postImagesURLs = [PostURLWithTime]()
                    
                    for snapValue in snapDict {
                        if postsIDs.contains(snapValue.key) {
                            guard let postURl = snapValue.value["postImageURL"] as? String else { print("Could not find postImageURL in dict"); return }
                            guard let creationTimeSince1970 = snapValue.value["creationTimeSince1970"] as? Double else { print("Could not find creationTimeSince1970 in dict"); return }
                            let postURLWithTime = PostURLWithTime(url: postURl, time: creationTimeSince1970)
                            postImagesURLs.append(postURLWithTime)
                        }
                    }
                    
                    //Create profile object and pass it back to the interactor
                    let sortedPostImagesURLs = postImagesURLs.sorted { $0.time < $1.time }
                    let profileObject = Profile(name: name, postsImageURL: sortedPostImagesURLs, profileImageURL: profileImageURL)
                    self?.remoteRequestHandler?.gotProfileObject(profileObject: profileObject)
                })
            } else {
                //In case user does not have any posts uploaded just create profile object and pass it back to the interactor
                let profileObject = Profile(name: name, postsImageURL: nil, profileImageURL: profileImageURL)
                self?.remoteRequestHandler?.gotProfileObject(profileObject: profileObject)
            }
        }
    }
    
    
    
}
