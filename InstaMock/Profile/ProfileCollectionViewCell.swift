//
//  ProfileCollectionViewCell.swift
//  InstaMock
//
//  Created by Gabriel Castillo Serafim on 23/12/22.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {
    
    static let id = "CollectionCellID"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupContentView() {
        
        contentView.addSubview(postImage)
        postImage.frame = contentView.bounds
    }
    
    var postImage: UIImageView = {
       
        let image = UIImageView()
        image.backgroundColor = .red
        image.clipsToBounds = true
        
        return image
    }()
}
