//
//  ProfileView.swift
//  InstaMock
//
//  Created by Gabriel Castillo Serafim on 21/12/22.
//  
//

import Foundation
import UIKit
import SDWebImage
import SkeletonView

class ProfileView: UIViewController {

    // MARK: Properties
    var presenter: ProfilePresenterProtocol?
    private let profilePicture = UIImageView()
    private let nameLabel = UILabel()
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let noPostsLabel = UILabel()

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        
        view.backgroundColor = .white
        title = "Profile"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logOutTapped))
        view.addSubview(profilePicture)
        view.addSubview(nameLabel)
        view.addSubview(collectionView)
        view.addSubview(noPostsLabel)
        
        profilePicture.layer.cornerRadius = 45
        profilePicture.layer.masksToBounds = true
        profilePicture.translatesAutoresizingMaskIntoConstraints = false
        profilePicture.isSkeletonable = true
        
        nameLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.isSkeletonable = true
        nameLabel.linesCornerRadius = 7
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: ProfileCollectionViewCell.id)
        collectionView.isSkeletonable = true
        
        noPostsLabel.text = "No Posts"
        noPostsLabel.textColor = .lightGray
        noPostsLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        noPostsLabel.translatesAutoresizingMaskIntoConstraints = false
        noPostsLabel.isHidden = true
        
        NSLayoutConstraint.activate([
            profilePicture.heightAnchor.constraint(equalToConstant: 90),
            profilePicture.widthAnchor.constraint(equalToConstant: 90),
            profilePicture.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            profilePicture.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: profilePicture.trailingAnchor, constant: 15),
            nameLabel.centerYAnchor.constraint(equalTo: profilePicture.centerYAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: profilePicture.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            noPostsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noPostsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100)
        ])
    }
    
    @objc private func logOutTapped() {
        
        presenter?.logOutTapped()
    }
}

//MARK: - UICollectionViewDataSource

extension ProfileView: SkeletonCollectionViewDataSource {
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        return ProfileCollectionViewCell.id
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.imagesDataSource.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.id, for: indexPath) as! ProfileCollectionViewCell
        
        let image = presenter?.imagesDataSource[indexPath.row]
        
        cell.postImage.image = image
        
        return cell
    }
}

//MARK: - UICollectionViewFlowLayout

extension ProfileView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //Since we want to layout 3 collectionView cells per row we have to calculate the cells sizes by dividing the width of the screen by 3 and subtracting from that value the actual spacing that we are going to between cells in the methods below, all 3 methods influence.
        return CGSize(width: (view.frame.size.width/3)-4, height: (view.frame.size.width/3)-4)
    }
    
    //Its important to set a value as zero otherwise the system uses a default value for the spacing that is not zero
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    //This sets the padding for the external part of the collection view, the external parts that normally are in contact with the screen borders, this does not influence in the internal spacing between cells.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
    }
}

extension ProfileView: ProfileViewProtocol {
    // TODO: implement view output methods
    
    func populateViewWithPostImages(profileObject: Profile) {
        DispatchQueue.main.async {
            self.nameLabel.text = profileObject.name
            self.profilePicture.sd_setImage(with: URL(string: profileObject.profileImageURL))
            self.collectionView.reloadData()
            self.noPostsLabel.isHidden = true
        }
    }
    
    func populateViewWithoutPostImages(profileObject: Profile) {
        DispatchQueue.main.async {
            self.nameLabel.text = profileObject.name
            self.profilePicture.sd_setImage(with: URL(string: profileObject.profileImageURL))
            self.noPostsLabel.isHidden = false
        }
    }
    
    func showSkeletonView() {
        DispatchQueue.main.async {
            self.profilePicture.showAnimatedGradientSkeleton()
            self.nameLabel.showAnimatedGradientSkeleton()
            self.collectionView.showAnimatedGradientSkeleton()
        }
    }
    
    func hideSkeletonView() {
        DispatchQueue.main.async {
            self.view.hideSkeleton()
        }
    }
}
