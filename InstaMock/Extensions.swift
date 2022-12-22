//
//  Extensions.swift
//  InstaMock
//
//  Created by Gabriel Castillo Serafim on 22/12/22.
//

import Foundation

extension String {
    
    var formatted: String {
       
        let formatted1 = self.replacingOccurrences(of: ".", with: "_")
        let formatted2 = formatted1.replacingOccurrences(of: "@", with: "_")
        
        return formatted2
    }
}
