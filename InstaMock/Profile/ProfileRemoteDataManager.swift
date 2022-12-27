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
    private var database = FirebaseDatabase.Database.database().reference()
    
    func getUserInfoFromFirebase(for email: String) {
        
        database.child("\(email)").getData { [weak self] error, snapshot in
            guard let snapshotDict = snapshot?.value as? [String: Any] else { print("Error getting user snapshotDict"); return }
            
            //Get the user personal info
            guard let name = snapshotDict["name"] as? String,
                  let profileImageURL = snapshotDict["profileImageDownloadURL"] as? String,
                  let postsDict = snapshotDict["posts"] as? [String: Any]
            else { print("Error extracting snapDictData"); return }
            
            //Get an array with all the user's postsIDs from the postsDict
            var postsIDs = [String]()
            for item in postsDict {
                postsIDs.append(item.value as! String)
            }
            
            //Get the imageURL for each post that the user has
            self?.database.child("posts").getData(completion: { error, snapshot in
                guard let snapDict = snapshot?.value as? [String: [String: Any]] else { print("Error getting snapshot value as [String: [String: Any]]"); return }
                
                var postImagesURLs = [String]()
                
                for snapValue in snapDict {
                    if postsIDs.contains(snapValue.key) {
                        guard let postURl = snapValue.value["imageDownloadURL"] as? String else { return }
                        postImagesURLs.append(postURl)
                    }
                }
                
                //Create profile object and pass it back to the interactor
                let profileObject = Profile(name: name, postsImageURL: postImagesURLs, profileImageURL: profileImageURL)
                self?.remoteRequestHandler?.gotProfileObject(profileObject: profileObject)
            })
        }
    }
}
