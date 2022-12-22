//
//  LoginView.swift
//  InstaMock
//
//  Created by Gabriel Castillo Serafim on 21/12/22.
//  
//

import Foundation
import UIKit

class LoginView: UIViewController {

    // MARK: Properties
    var presenter: LoginPresenterProtocol?
    private let emailField = UITextField()
    private let passWordField = UITextField()
    private let loginButton = UIButton()

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        
        view.backgroundColor = .white
        view.addSubview(emailField)
        view.addSubview(passWordField)
        view.addSubview(loginButton)
        
        emailField.placeholder = "Email"
        emailField.backgroundColor = #colorLiteral(red: 0.8955142436, green: 0.9043807213, blue: 0.9043807213, alpha: 1)
        emailField.translatesAutoresizingMaskIntoConstraints = false
        
        passWordField.placeholder = "PassWord"
        passWordField.backgroundColor = #colorLiteral(red: 0.8955142436, green: 0.9043807213, blue: 0.9043807213, alpha: 1)
        passWordField.isSecureTextEntry = true
        passWordField.translatesAutoresizingMaskIntoConstraints = false
        
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = .black
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emailField.heightAnchor.constraint(equalToConstant: 52),
            emailField.widthAnchor.constraint(equalToConstant: 300),
            emailField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50)
        ])
        
        NSLayoutConstraint.activate([
            passWordField.heightAnchor.constraint(equalToConstant: 52),
            passWordField.widthAnchor.constraint(equalToConstant: 300),
            passWordField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passWordField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50)
        ])
            
        NSLayoutConstraint.activate([
            loginButton.heightAnchor.constraint(equalToConstant: 52),
            loginButton.widthAnchor.constraint(equalToConstant: 300),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200)
        ])
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailField.endEditing(true)
        passWordField.endEditing(true)
    }
    
    @objc private func loginButtonTapped() {
        
        presenter?.userTappedLogin(email: emailField.text, password: passWordField.text)
    }
    
}

extension LoginView: LoginViewProtocol {
    
    // TODO: implement view output methods
    
    func showMissingFieldAlert() {
        
        let alertController = UIAlertController(title: "Error", message: "Please fill all field in order to proceed", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
        self.present(alertController, animated: true)
    }
}
