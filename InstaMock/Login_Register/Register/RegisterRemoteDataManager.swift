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
    
    func createUserNodeInRemoteDB(with name: String, _ email: String) {
        
        let formattedEmail = email.formatted
        let userDict = ["name": name, "email": email]
        
        database.child("\(formattedEmail)").updateChildValues(userDict)
    }
    
    func uploadProfilePictureToFireStore(image: UIImage, email: String) {
        
        let randomNumber = Date().timeIntervalSince1970
        let imageID = "\(email.formatted)\(randomNumber)_profile_picture.png"
        let imageData = image.pngData()
        guard let imageData = imageData else { print("Error gettingProfileImage pngData()"); return }
        
        storage.child("images/\(imageID)").putData(imageData) { [weak self] _, error in
            guard error == nil else { print("Error uploadingImage: \(error!.localizedDescription)"); return }
            
            self?.remoteRequestHandler?.finishedUploadingUserPhoto()
        }
    }
    
}
