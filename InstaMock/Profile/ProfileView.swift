//
//  ProfileView.swift
//  InstaMock
//
//  Created by Gabriel Castillo Serafim on 21/12/22.
//  
//

import Foundation
import UIKit

class ProfileView: UIViewController {

    // MARK: Properties
    var presenter: ProfilePresenterProtocol?
    private let profilePicture = UIImageView()
    private let nameLabel = UILabel()
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        
        view.backgroundColor = .white
        title = "Profile"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logOutTapped))
        view.addSubview(profilePicture)
        view.addSubview(nameLabel)
        view.addSubview(collectionView)
        
        profilePicture.backgroundColor = .black
        profilePicture.layer.cornerRadius = 45
        profilePicture.layer.masksToBounds = true
        profilePicture.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.text = "Gabriel Castillo Serafim"
        nameLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: ProfileCollectionViewCell.id)
        
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
    }
    
    @objc private func logOutTapped() {
        
        presenter?.logOutTapped()
    }
}

//MARK: - UICollectionViewDataSource

extension ProfileView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.id, for: indexPath) as! ProfileCollectionViewCell
        
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
}
