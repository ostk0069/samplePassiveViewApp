//
//  UserDetailPresenter.swift
//  samplePassiveViewApp
//
//  Created by Takuma Osada on 2019/05/03.
//  Copyright © 2019 Takuma Osada. All rights reserved.
//

import Foundation

protocol UserDetailPresenterInput {
    var repositories: [Repository] { get }
    func repository(forRow row: Int) -> Repository?
    func viewDidLoad()
}

protocol UserDetailPresenterOutput {
    func updateRepositories(_ repositories: [Repository])
}

final class UserDetailPresenter: UserDetailPresenterInput {

    private var name: String
    var repositories: [Repository] = []
    
    private var view: UserDetailPresenterOutput!
    private var model: UserDetailModelInput
    
    init(name: String, view: UserDetailPresenterOutput, model: UserDetailModelInput) {
        self.name = name
        self.view = view
        self.model = model
    }
    
    func repository(forRow row: Int) -> Repository? {
        guard row < repositories.count else {
            return nil
        }
        return repositories[row]
    }
    
    func viewDidLoad() {
        model.fetchRepositories { [weak self] result in
            switch result {
            case .success(let repositories):
                self?.repositories = repositories
                
                DispatchQueue.main.sync {
                    self?.view.updateRepositories(repositories)
                }
            case .failure:
                ()
            }
        }
    }
}
