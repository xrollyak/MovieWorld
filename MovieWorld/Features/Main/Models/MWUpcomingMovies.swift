//
//  MWUpcomingMovies.swift
//  MovieWorld
//
//  Created by Nadya Khrol on 07.04.2021.
//

import Foundation
//
//"poster_path": "/pEFRzXtLmxYNjGd0XqJDHPDFKB2.jpg",
//"adult": false,
//"overview": "A lighthouse keeper and his wife living off the coast of Western Australia raise a baby they rescue from an adrift rowboat.",
//"release_date": "2016-09-02",
//"genre_ids": [
//  18
//],
//"id": 283552,
//"original_title": "The Light Between Oceans",
//"original_language": "en",
//"title": "The Light Between Oceans",
//"backdrop_path": "/2Ah63TIvVmZM3hzUwR5hXFg2LEk.jpg",
//"popularity": 4.546151,
//"vote_count": 11,
//"video": false,
//"vote_average": 4.41

struct UpcomingDate: Decodable {
    let minimum: String?
    let maximum: String?

}

struct MWUpcomingMovies: Decodable {
    let page: Int
    let results: [MWMovie]
    let dates: UpcomingDate
    let total_results: Int
    let total_pages: Int
}
