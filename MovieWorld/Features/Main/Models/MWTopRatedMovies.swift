//
//  MWTopRatedMovies.swift
//  MovieWorld
//
//  Created by Nadya Khrol on 07.04.2021.
//

import Foundation

struct MWTopRatedMovies: Decodable {
    let page: Int
    let results: [MWMovie]
    let total_results: Int
    let total_pages: Int
}
