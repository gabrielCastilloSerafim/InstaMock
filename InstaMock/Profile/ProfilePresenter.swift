//
//  ProfilePresenter.swift
//  InstaMock
//
//  Created by Gabriel Castillo Serafim on 21/12/22.
//  
//

import UIKit

class ProfilePresenter  {
    
    // MARK: Properties
    weak var view: ProfileViewProtocol?
    var interactor: ProfileInteractorInputProtocol?
    var wireFrame: ProfileWireFrameProtocol?
    var imagesDataSource = [UIImage]()
    
}

extension ProfilePresenter: ProfilePresenterProtocol {

    // TODO: implement presenter methods
    func viewDidLoad() {
        view?.showSkeletonView()
        interactor?.getUserInfo()
    }
    
    func logOutTapped() {
        interactor?.performUserLogOut()
    }
    
}

extension ProfilePresenter: ProfileInteractorOutputProtocol {
    
    // TODO: implement interactor output methods
    
    func didLogUserOut() {
        wireFrame?.goToLoginView(fromVC: view as! ProfileView)
    }
    
    func didReceiveProfileInfo(profileObject: Profile) {
        
        let profileImagesNumber = profileObject.postsImageURL.count
        var counter: Int = 0 {
            didSet {
                if counter == profileImagesNumber {
                    view?.hideSkeletonView()
                    view?.populateView(profileObject: profileObject)
                }
            }
        }
        
        for url in profileObject.postsImageURL {
            let url = URL(string: url)!
            URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                guard let data = data else { print("Error Downloading profile image"); return }
                guard let image = UIImage(data: data) else { print("Error parsing image"); return }
                self?.imagesDataSource.append(image)
                counter += 1
            }.resume()
        }
        
    }
}
