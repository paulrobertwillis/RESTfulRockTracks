//
//  DomainEntityMock.swift
//  RESTfulRockTracksTests
//
//  Created by Paul Willis on 29/08/2022.
//

import Foundation

public struct DomainEntityMock: Equatable {
    let id: String
    let name: String?
}

extension Data {
    public static func mockSuccessResponse() -> Self {
        """
        {
          "results": [
            {
              "id": 28,
              "name": "Action"
            }
          ]
        }
        """.data(using: .utf8)!
    }
}

