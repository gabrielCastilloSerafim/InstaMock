//
//  FeedView.swift
//  InstaMock
//
//  Created by Gabriel Castillo Serafim on 21/12/22.
//  
//

import Foundation
import UIKit
import SDWebImage

class FeedView: UIViewController, FeedTableViewCellDelegate {

    // MARK: Properties
    var presenter: FeedPresenterProtocol?
    private let tableView = UITableView()

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        presenter?.viewDidLoad()
    }
    
    private func setupView() {
        
        view.backgroundColor = .white
        title = "Feed"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addButtonTapped))
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: FeedTableViewCell.feedCellID)
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.allowsSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func addButtonTapped() {
        
        presenter?.addPostTapeed()
    }
    
    func likeButtonTapped(numberOfLikes: Int) {
        
    }
    
    func expandTextButtonTapped() {
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}

//MARK: - TableView DataSource

extension FeedView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.postsDataSource.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.feedCellID, for: indexPath) as! FeedTableViewCell
        
        let postObject = presenter?.postsDataSource[indexPath.row]
        
        cell.delegate = self
        cell.nameLabel.text = postObject?.creatorName
        cell.captionLabel.text = postObject?.postCaption
        cell.numberOfLikesLabel.text = String(describing: postObject!.numberOfLikes)
        cell.postImage.sd_setImage(with: URL(string: (postObject?.postImageURL)!))
        cell.profileImage.sd_setImage(with: URL(string: (postObject?.creatorProfilePictureURL)!))
        
        return cell
    }
}

extension FeedView: FeedViewProtocol {
    // TODO: implement view output methods
    
    func reloadTableView() {
        tableView.reloadData()
    }
}

