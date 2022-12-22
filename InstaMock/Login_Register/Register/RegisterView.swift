//
//  RegisterView.swift
//  InstaMock
//
//  Created by Gabriel Castillo Serafim on 21/12/22.
//  
//

import Foundation
import UIKit
import JGProgressHUD

class RegisterView: UIViewController {

    // MARK: Properties
    var presenter: RegisterPresenterProtocol?
    private let profileImage = UIImageView()
    private let nameTextField = UITextField()
    private let emailField = UITextField()
    private let passWordField = UITextField()
    private let registerButton = UIButton()
    private let imagePicker = UIImagePickerController()
    private let spinner = JGProgressHUD(style: .dark)

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        
        view.backgroundColor = .white
        view.addSubview(profileImage)
        view.addSubview(nameTextField)
        view.addSubview(emailField)
        view.addSubview(passWordField)
        view.addSubview(registerButton)
        
        
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        profileImage.image = UIImage(systemName: "person.circle")
        profileImage.tintColor = .lightGray
        profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profileImageTapped)))
        profileImage.layer.cornerRadius = 45
        profileImage.layer.masksToBounds = true
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        
        nameTextField.placeholder = "Full Name"
        nameTextField.backgroundColor = #colorLiteral(red: 0.8955142436, green: 0.9043807213, blue: 0.9043807213, alpha: 1)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        emailField.placeholder = "Email"
        emailField.backgroundColor = #colorLiteral(red: 0.8955142436, green: 0.9043807213, blue: 0.9043807213, alpha: 1)
        emailField.translatesAutoresizingMaskIntoConstraints = false
        
        passWordField.placeholder = "PassWord"
        passWordField.backgroundColor = #colorLiteral(red: 0.8955142436, green: 0.9043807213, blue: 0.9043807213, alpha: 1)
        passWordField.isSecureTextEntry = true
        passWordField.translatesAutoresizingMaskIntoConstraints = false
        
        registerButton.setTitle("Register", for: .normal)
        registerButton.backgroundColor = .black
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileImage.heightAnchor.constraint(equalToConstant: 90),
            profileImage.widthAnchor.constraint(equalToConstant: 90),
            profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            nameTextField.heightAnchor.constraint(equalToConstant: 52),
            nameTextField.widthAnchor.constraint(equalToConstant: 300),
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150)
        ])
        
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
            registerButton.heightAnchor.constraint(equalToConstant: 52),
            registerButton.widthAnchor.constraint(equalToConstant: 300),
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailField.endEditing(true)
        passWordField.endEditing(true)
    }
    
    @objc private func registerButtonTapped() {
        
        presenter?.registerButtonPressed(name: nameTextField.text, email: emailField.text, password: passWordField.text, profileImage: profileImage.image)
    }
    
    @objc private func profileImageTapped() {
        
        presenter?.profilePictureTapped()
    }
    

}

//MARK: - ImagePickerController Delegate
extension RegisterView: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        presenter?.userSelectedImage(image: info[.editedImage] as? UIImage)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        presenter?.userCancelledImagePicker()
    }
}


extension RegisterView: RegisterViewProtocol {
    
    // TODO: implement view output methods
    
    func showAlert() {
        
        let alert = UIAlertController(title: "Error", message: "Please fill all fields in order to proceed", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
        self.present(alert, animated: true)
    }
    
    func showSpinner() {
        spinner.show(in: view, animated: true)
    }
    
    func hideSpinner() {
        spinner.dismiss(animated: true)
    }
    
    func presentImagePickerController() {
        self.present(imagePicker, animated: true)
    }
    
    func dismissImagePicker() {
        imagePicker.dismiss(animated: true)
    }
    
    func placeSelectedImageInProfileImageView(image: UIImage) {
        DispatchQueue.main.async {
            self.profileImage.image = image
        }
    }
}
