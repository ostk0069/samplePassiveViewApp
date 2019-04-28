//
//  SessionError.swift
//  samplePassiveViewApp
//
//  Created by Takuma Osada on 2019/04/28.
//  Copyright © 2019 Takuma Osada. All rights reserved.
//

import Foundation

public enum SessionError: Error {
  
  case noData(HTTPURLResponse)
  case noResponse
  case unacceptableStatusCode(Int, Message?)
  case failedToCreateComponents(URL)
  case failedToCreateURL(URLComponents)
}

extension SessionError {
  public struct Message: Decodable {
    public let documentationURL: URL
    public let message: String
    
    private enum CodingKeys: String, CodingKey {
      case documentationURL = "documentation_url"
      case message
    }
  }
}
