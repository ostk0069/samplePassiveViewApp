//
//  Result.swift
//  samplePassiveViewApp
//
//  Created by Takuma Osada on 2019/04/28.
//  Copyright © 2019 Takuma Osada. All rights reserved.
//

import Foundation

public enum Result<T> {
  case success(T)
  case failure(Error)
}
