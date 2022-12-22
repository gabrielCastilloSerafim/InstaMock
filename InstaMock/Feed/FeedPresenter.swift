//
//  FeedPresenter.swift
//  InstaMock
//
//  Created by Gabriel Castillo Serafim on 21/12/22.
//  
//

import Foundation

class FeedPresenter  {
    
    // MARK: Properties
    weak var view: FeedViewProtocol?
    var interactor: FeedInteractorInputProtocol?
    var wireFrame: FeedWireFrameProtocol?
    
}

extension FeedPresenter: FeedPresenterProtocol {
    // TODO: implement presenter methods
    func viewDidLoad() {
    }
}

extension FeedPresenter: FeedInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
