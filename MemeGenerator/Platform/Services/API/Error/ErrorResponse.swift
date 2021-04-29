//
//  ErrorResponse.swift
//  MemeGenerator
//
//  Created by than.duc.huy on 27/04/2021.
//

import Foundation

enum ErrorRequest: Error {
    case networkError
    case httpError(httpCode: Int)
    case unexpectedError
}
