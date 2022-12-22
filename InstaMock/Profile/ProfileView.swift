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

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Profile"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "LogOut", style: .plain, target: self, action: #selector(logOutTapped))
    }
    
    @objc private func logOutTapped() {
        print("LogOut Tapped")
    }
}

extension ProfileView: ProfileViewProtocol {
    // TODO: implement view output methods
}
