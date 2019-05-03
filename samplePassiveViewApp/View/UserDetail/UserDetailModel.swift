//
//  UserDetailModel.swift
//  samplePassiveViewApp
//
//  Created by Takuma Osada on 2019/05/03.
//  Copyright © 2019 Takuma Osada. All rights reserved.
//

import Foundation

protocol UserDetailModelInput {
    func fetchRepositories(completion: @escaping (Result<[Repository]>) -> ())
}

final class UserDetailModel: UserDetailModelInput {
    private let name: String!
    
    init(name: String) {
        self.name = name
    }
    
    func fetchRepositories(completion: @escaping (Result<[Repository]>) -> ()) {
        let session = Session()
        let request = UserReposRequest(username: name,
                                       type: nil,
                                       sort: nil,
                                       direction: nil,
                                       page: nil,
                                       perPage: nil)
        session.send(request) { result in
            switch result {
            case .success(let response):
                completion(.success(response.0))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}


