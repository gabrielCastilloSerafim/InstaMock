//
//  Post.swift
//  InstaMock
//
//  Created by Gabriel Castillo Serafim on 29/12/22.
//

import UIKit

struct Post {
    let creatorName: String
    let creatorEmail: String
    let creationTimeSince1970: Double
    let postID: String
    let postImageID: String?
    let postImageURL: String?
    let postImage: UIImage?
    let postCaption: String
    let numberOfLikes: Int
    let creatorProfilePictureURL: String?
}
