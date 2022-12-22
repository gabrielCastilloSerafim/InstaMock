//
//  Login_RegisterView.swift
//  InstaMock
//
//  Created by Gabriel Castillo Serafim on 21/12/22.
//  
//

import Foundation
import UIKit

class Login_RegisterView: UIViewController {

    // MARK: Properties
    var presenter: Login_RegisterPresenterProtocol?
    private let loginButton = UIButton()
    private let registerButton = UIButton()

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        
        view.backgroundColor = .white
        
        view.addSubview(loginButton)
        view.addSubview(registerButton)
        
        loginButton.backgroundColor = .black
        loginButton.setTitle("Login", for: .normal)
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        registerButton.backgroundColor = .black
        registerButton.setTitle("Register", for: .normal)
        registerButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loginButton.heightAnchor.constraint(equalToConstant: 52),
            loginButton.widthAnchor.constraint(equalToConstant: 300),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50)
        ])
        
        NSLayoutConstraint.activate([
            registerButton.heightAnchor.constraint(equalToConstant: 52),
            registerButton.widthAnchor.constraint(equalToConstant: 300),
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50)
        ])
    }
    
    @objc private func loginTapped() {
        presenter?.loginTapped(fromVC: self)
    }
    
    @objc private func registerTapped() {
        presenter?.registerTapped(fromVC: self)
    }
    
    
}

extension Login_RegisterView: Login_RegisterViewProtocol {
    // TODO: implement view output methods
}
