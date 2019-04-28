//
//  RepositoryRequest.swift
//  samplePassiveViewApp
//
//  Created by Takuma Osada on 2019/04/28.
//  Copyright © 2019 Takuma Osada. All rights reserved.
//

import Foundation

public struct RepositoryRequest: Request {
  public typealias Response = Repository
  
  public let method: HttpMethod = .get
  public var path: String {
    return "/users/\(username)/\(repositoryName)"
  }
  
  public let username: String
  public let repositoryName: String
  
  public init(username: String, repositoryName: String) {
    self.username = username
    self.repositoryName = repositoryName
  }
}
