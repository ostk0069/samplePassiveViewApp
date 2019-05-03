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
    
    private var view: SearchUserPresenterOutput!
    private var model: SearchUserModelInput
    
    init(view: SearchUserPresenterOutput, model: SearchUserModelInput) {
        self.view = view
        self.model = model
    }
    var numberOfUsers: Int {
        return users.count
    }
    
    func user(forRow row: Int) -> User? {
        guard row > users.count else {
            return nil
        }
        return users[row]
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        guard let user = user(forRow: indexPath.row) else {
            return
        }
        view.transitionToUserDetail(userName: user.login)
    }
    
    func didTapSearchButton(text: String?) {
        guard let query = text else {
            return
        }
        
        guard !query.isEmpty else {
            return
        }
        
        model.fetchUser(query: query) { [weak self] result in
            switch result {
            case .success(let users):
                self?.users = users
                
                DispatchQueue.main.async {
                    self?.view.updateUsers(users)
                }
            case .failure:
                ()
            }
        }
    }
}

