//
//  TableViewCell.swift
//  InstaMock
//
//  Created by Gabriel Castillo Serafim on 22/12/22.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    static let feedCellID = "feedCellId"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupContentView() {
        
        //contentView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        contentView.addSubview(profileImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(postImage)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            profileImage.heightAnchor.constraint(equalToConstant: 36),
            profileImage.widthAnchor.constraint(equalToConstant: 36),
            profileImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            profileImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 15),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            nameLabel.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            postImage.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            postImage.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            postImage.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 20),
            postImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
    }
    
    var profileImage: UIImageView = {
       
        let image = UIImageView()
        image.backgroundColor = .black
        image.layer.cornerRadius = 18
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    var postImage: UIImageView = {
       
        let image = UIImageView()
        image.backgroundColor = .lightGray
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    var nameLabel: UILabel = {
    
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    
}
