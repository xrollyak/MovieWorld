//
//  MWPopularMoviesResponce.swift
//  MovieWorld
//
//  Created by Nadya Khrol on 05.04.2021.
//

import Foundation

struct MWPopularMoviesResponce: Decodable {
    let page: Int
    let results: [MWMovie]
    let total_results: Int
    let total_pages: Int
}
