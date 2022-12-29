//
//  Profile.swift
//  InstaMock
//
//  Created by Gabriel Castillo Serafim on 23/12/22.
//

import Foundation

struct Profile {
    
    let name: String
    var postsImageURL: [PostURLWithTime]?
    let profileImageURL: String
}

struct PostURLWithTime {
    let url: String
    let time: Double
}
