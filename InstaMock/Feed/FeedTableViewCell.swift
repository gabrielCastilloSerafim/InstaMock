//
//  TableViewCell.swift
//  InstaMock
//
//  Created by Gabriel Castillo Serafim on 22/12/22.
//

import UIKit
import SkeletonView

protocol FeedTableViewCellDelegate {
    func likeButtonTapped(buttonTag: Int, isDislike: Bool)
    func expandTextButtonTapped()
}

class FeedTableViewCell: UITableViewCell {

    static let feedCellID = "feedCellId"
    var delegate: FeedTableViewCellDelegate?
    var isLiked = false

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupContentView() {
        
        contentView.addSubview(profileImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(postImage)
        contentView.addSubview(likeButton)
        contentView.addSubview(numberOfLikesLabel)
        contentView.addSubview(likesLabel)
        contentView.addSubview(expandCaptionButton)
        contentView.addSubview(captionLabel)
        //Make contentView skeletonable
        isSkeletonable = true
        
        likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
        expandCaptionButton.addTarget(self, action: #selector(didTapExpandButton), for: .touchUpInside)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            profileImage.heightAnchor.constraint(equalToConstant: 40),
            profileImage.widthAnchor.constraint(equalToConstant: 40),
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
            postImage.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            likeButton.heightAnchor.constraint(equalToConstant: 27),
            likeButton.widthAnchor.constraint(equalToConstant: 27),
            likeButton.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 15),
            likeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            numberOfLikesLabel.topAnchor.constraint(equalTo: likeButton.bottomAnchor, constant: 15),
            numberOfLikesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            likesLabel.topAnchor.constraint(equalTo: likeButton.bottomAnchor, constant: 15),
            likesLabel.leadingAnchor.constraint(equalTo: numberOfLikesLabel.trailingAnchor, constant: 4)
        ])
        
        NSLayoutConstraint.activate([
            expandCaptionButton.widthAnchor.constraint(equalToConstant: 36),
            expandCaptionButton.topAnchor.constraint(equalTo: numberOfLikesLabel.bottomAnchor, constant: 15),
            expandCaptionButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            captionLabel.topAnchor.constraint(equalTo: numberOfLikesLabel.bottomAnchor, constant: 15),
            captionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            captionLabel.trailingAnchor.constraint(equalTo: expandCaptionButton.leadingAnchor, constant: -5),
            captionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
    
    @objc private func didTapLikeButton() {
        
        let numberOfLikes = Int(numberOfLikesLabel.text!)!
        
        if isLiked == false {
            numberOfLikesLabel.text = String("\(numberOfLikes+1)")
            likeButton.setImage(UIImage(systemName: "hand.thumbsup.fill"), for: .normal)
        } else {
            numberOfLikesLabel.text = String("\(numberOfLikes-1)")
            likeButton.setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
        }
        
        delegate?.likeButtonTapped(buttonTag: likeButton.tag, isDislike: isLiked)
        isLiked = !isLiked
    }
    
    @objc private func didTapExpandButton() {
        
        expandCaptionButton.isHidden = true
        captionLabel.numberOfLines = 0
        
        delegate?.expandTextButtonTapped()
    }
    
    var profileImage: UIImageView = {
       
        let image = UIImageView()
        image.backgroundColor = .black
        image.layer.cornerRadius = 20
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isSkeletonable = true
        
        return image
    }()
    
    var postImage: UIImageView = {
       
        let image = UIImageView()
        image.backgroundColor = .lightGray
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isSkeletonable = true
        
        return image
    }()
    
    var nameLabel: UILabel = {
    
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isSkeletonable = true
        label.linesCornerRadius = 7
        
        return label
    }()
    
    var likeButton: UIButton = {
       
        let button = UIButton(type: .custom)
        button.imageView?.contentMode = .scaleAspectFill
        button.setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.tintColor = .systemGreen
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isSkeletonable = true
        button.isHiddenWhenSkeletonIsActive = true
        
        return button
    }()
    
    var likesLabel: UILabel = {
       
        let label = UILabel()
        label.text = "Likes"
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isSkeletonable = true
        label.isHiddenWhenSkeletonIsActive = true
        
        return label
    }()
    
    var numberOfLikesLabel: UILabel = {
       
        let label = UILabel()
        label.text = "0"
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isSkeletonable = true
        label.isHiddenWhenSkeletonIsActive = true
        
        return label
    }()
    
    var captionLabel: UILabel = {
       
        let label = UILabel()
        label.text = "Gabriel Castillo: This is my post caption This is my post caption This is my post caption This is my post caption This is my post caption This is my post caption"
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isSkeletonable = true
        label.isHiddenWhenSkeletonIsActive = true
        
        return label
    }()
    
    var expandCaptionButton: UIButton = {
       
        let button = UIButton()
        button.setTitle("More", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isSkeletonable = true
        button.isHiddenWhenSkeletonIsActive = true
        
        return button
    }()
    
}
