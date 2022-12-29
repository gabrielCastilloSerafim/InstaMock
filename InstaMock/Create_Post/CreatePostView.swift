//
//  CreatePostView.swift
//  InstaMock
//
//  Created by Gabriel Castillo Serafim on 28/12/22.
//  
//

import Foundation
import UIKit
import JGProgressHUD

class CreatePostView: UIViewController {

    // MARK: Properties
    var presenter: CreatePostPresenterProtocol?
    private let imageView = UIImageView()
    private let captionLabel = UILabel()
    private let captionTextField = UITextField()
    private let postButton = UIButton()
    private let actionSheet = UIAlertController(title: "Select Image", message: "Take a picture or choose one from the library?", preferredStyle: .actionSheet)
    private let imagePicker = UIImagePickerController()
    private let emptyCaptionAlert = UIAlertController(title: "Attention", message: "Please write a caption in order to create the post.", preferredStyle: .alert)
    private let spinner = JGProgressHUD(style: .dark)
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        
        //View
        view.backgroundColor = .white
        view.addSubview(imageView)
        view.addSubview(captionLabel)
        view.addSubview(captionTextField)
        view.addSubview(postButton)
        
        //ImageView
        imageView.image = UIImage(systemName: "camera.on.rectangle")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
        imageView.addGestureRecognizer(tapRecognizer)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50)
        ])
        
        //CaptionLabel
        captionLabel.text = "Write caption bellow:"
        captionLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        captionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            captionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 60),
            captionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            captionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        //CaptionTextField
        captionTextField.translatesAutoresizingMaskIntoConstraints = false
        captionTextField.borderStyle = .roundedRect
        
        NSLayoutConstraint.activate([
            captionTextField.topAnchor.constraint(equalTo: captionLabel.bottomAnchor, constant: 30),
            captionTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            captionTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        //Post Button
        postButton.setTitle("Post", for: .normal)
        postButton.backgroundColor = .black
        postButton.titleLabel?.textColor = .white
        postButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        postButton.translatesAutoresizingMaskIntoConstraints = false
        postButton.layer.cornerRadius = 25
        postButton.layer.masksToBounds = true
        postButton.addTarget(self, action: #selector(didTapPost), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            postButton.heightAnchor.constraint(equalToConstant: 52),
            postButton.topAnchor.constraint(equalTo: captionTextField.bottomAnchor, constant: 30),
            postButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            postButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        //ActionSheet
        actionSheet.addAction(UIAlertAction(title: "Open Album", style: .default, handler: { [weak self] _ in self?.openAlbumSelected()}))
        actionSheet.addAction(UIAlertAction(title: "Open Camera", style: .default, handler: { [weak self] _ in self?.openCameraSelected()}))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .destructive))
        
        //ImagePicker
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        //Empty caption alert
        emptyCaptionAlert.addAction(UIAlertAction(title: "Dismiss", style: .default))
    }
    
    @objc private func didTapImage() {
        presenter?.imageGotTapped()
    }
    
    @objc private func didTapPost() {
        presenter?.userTappedPostButton(selectedImage: imageView.image!, caption: captionTextField.text)
    }
    
    private func openAlbumSelected() {
        presenter?.userSelectedAlbum()
    }
    
    private func openCameraSelected() {
        presenter?.userSelectedCamera()
    }
    
    
                              
}

//MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate

extension CreatePostView: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        presenter?.userSelectedImage(selectedImage: info[.editedImage] as? UIImage)
    }
}

extension CreatePostView: CreatePostViewProtocol {
    // TODO: implement view output methods
    
    func presentActionSheet() {
        self.present(actionSheet, animated: true)
    }
    
    func presentImagePicker() {
        self.present(imagePicker, animated: true)
    }
    
    func presentCamera() {
        imagePicker.sourceType = .camera
        self.present(imagePicker, animated: true)
    }
    
    func putSelectedImageInImageView(selectedImage: UIImage) {
        DispatchQueue.main.async {
            self.imageView.image = selectedImage
        }
    }
    
    func dismissImagePicker() {
        dismiss(animated: true)
    }
    
    func showEmptyCaptionAlert() {
        self.present(emptyCaptionAlert, animated: true)
    }
    
    func showSpinner() {
        spinner.show(in: view, animated: true)
    }
    
    func hideSpinner() {
        spinner.dismiss(animated: true)
    }
    
}
