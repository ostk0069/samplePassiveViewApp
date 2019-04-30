//
//  SearchUserPresenter.swift
//  samplePassiveViewApp
//
//  Created by Takuma Osada on 2019/04/30.
//  Copyright © 2019 Takuma Osada. All rights reserved.
//

import Foundation

protocol SearchUserPresenterInput {
  
    var numberOfUsers: Int { get }
    func user(forRow row: Int) -> User?
    func didSelectRow(at indexPath: IndexPath)
    func didTapSearchButton(text: String?)
}

protocol SearchUserPresenterOutput {
    
    func updateUsers(_ users: [User])
    func transitionToUserDetail(userName: String)
}

final class SearchPresenter: SearchUserPresenterInput {
    
    private(set) var users: [User] = []
    
    private weak var view: SearchUserPresenterOutput!
    private weak var model: SearchUserModelInput!
    
    init(view: SearchUserPresenterOutput, model: SearchUserModelInput) {
        self.view = view
        self.model = model
    }
    var numberOfUsers: Int
    
    func user(forRow row: Int) -> User? {
        <#code#>
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        <#code#>
    }
    
    func didTapSearchButton(text: String?) {
        <#code#>
    }
    
    
}

