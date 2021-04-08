//
//  MWTopRatedReponseModel.swift
//  MovieWorld
//
//  Created by Анастасия Корнеева on 8.04.21.
//

import Foundation

struct MWTopRatedReponseModel: Decodable {
    let page: Int
    let results: [MWMovie]
    let total_results: Int
    let total_pages: Int
}
