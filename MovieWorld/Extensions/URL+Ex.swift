//
//  URL+Ex.swift
//  MovieWorld
//
//  Created by Nadya Khrol on 05.04.2021.
//

import Foundation

extension URL {
init?(urlString: String, path: String = "", params: [String: String]? = nil) {
        guard var components = URLComponents(string: urlString + path) else { return nil }
        if let params = params {
            components.queryItems = params.map { URLQueryItem(name: $0.0, value: $0.1) }
        }
        guard let url = components.url else { return nil }
        self = url
    }
}
