//
//  MWErrors.swift
//  MovieWorld
//
//  Created by Анастасия Корнеева on 5.04.21.
//

import Foundation

enum MWNetError {
    case incorrectUrl
    case networkError(error: Error)
    case serverError(statusCode: Int)
    case parsingError(error: Error)
    case unknown
}
