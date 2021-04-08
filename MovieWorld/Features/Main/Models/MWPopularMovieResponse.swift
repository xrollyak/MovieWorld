//
//  MWPopularMovieResponse.swift
//  MovieWorld
//
//  Created by Анастасия Корнеева on 5.04.21.
//

import Foundation

struct MWPopularMovieResponse: Decodable {
    let page: Int
    let total_results: Int
    let total_pages: Int
    let results: [MWMovie]
}
