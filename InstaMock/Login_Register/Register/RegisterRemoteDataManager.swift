//
//  RegisterRemoteDataManager.swift
//  InstaMock
//
//  Created by Gabriel Castillo Serafim on 21/12/22.
//  
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

class RegisterRemoteDataManager:RegisterRemoteDataManagerInputProtocol {

    var remoteRequestHandler: RegisterRemoteDataManagerOutputProtocol?
    private let database = FirebaseDatabase.Database.database().reference()
    private let storage = FirebaseStorage.Storage.storage().reference()
    
    func createUserInFirebase(image: UIImage, email: String, name: String) {
        
        let randomNumber = Date().timeIntervalSince1970
        let imageID = "\(email.formatted)\(randomNumber)_profile_picture.png"
        let imageData = image.pngData()
        guard let imageData = imageData else { print("Error gettingProfileImage pngData()"); return }
        
        //Upload image to fireStore
        storage.child("images/\(imageID)").putData(imageData) { [weak self] _, error in
            guard error == nil else { print("Error uploadingImage: \(error!.localizedDescription)"); return }
            
            //Get users photo download url
            self?.storage.child("images/\(imageID)").downloadURL { url, error in
                guard let url = url?.absoluteString else { print("Error getting profile image url"); return }
                
                //Set user info in realTime database
                let formattedEmail = email.formatted
                let userDict = ["name": name, "email": email, "profileImageDownloadURL": url]
                self?.database.child("\(formattedEmail)").updateChildValues(userDict)
                
                self?.remoteRequestHandler?.finishedUploadingUserPhoto()
            }
        }
    }
    
}
