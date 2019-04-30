//
//  SearchUserModel.swift
//  samplePassiveViewApp
//
//  Created by Takuma Osada on 2019/04/30.
//  Copyright © 2019 Takuma Osada. All rights reserved.
//

import Foundation

protocol SearchUserModelInput {
  
    func fetchUser(
      query: String,
      completion: @escaping (Result<[User]>) -> ()
    )
}

final class SearchUserModel: SearchUserModelInput {
    
    func fetchUser(
        query: String,
        completion: @escaping (Result<[User]>) -> ()
    ) {
        let session = Session()
        
        let request = SearchUsersRequest(
            query: query,
            sort: nil,
            order: nil,
            page: nil,
            perPage: nil
        )
        
        session.send(request) { result in
            switch result {
            case .success(let response):
                completion(.success(response.0.items))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}


