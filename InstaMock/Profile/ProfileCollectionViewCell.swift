//
//  ProfileCollectionViewCell.swift
//  InstaMock
//
//  Created by Gabriel Castillo Serafim on 23/12/22.
//

import UIKit
import SkeletonView

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
        
        //Content View
        contentView.addSubview(postImage)
        isSkeletonable = true
        
        //PostImage
        postImage.isSkeletonable = true
        postImage.frame = contentView.bounds
    }
    
    var postImage: UIImageView = {
       
        let image = UIImageView()
        image.clipsToBounds = true
        
        return image
    }()
}
