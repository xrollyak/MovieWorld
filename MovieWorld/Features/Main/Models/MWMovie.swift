//
//  MWMovie.swift
//  MovieWorld
//
//  Created by Анастасия Корнеева on 5.04.21.
//

import UIKit

class MWMovie: Decodable {
    let id: Int
    let poster_path: String?
    let title: String
    let overview: String?
    let release_date: String
    // let release_date: Date
}
