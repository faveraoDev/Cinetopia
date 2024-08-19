//
//  Movie.swift
//  Cinetopia
//
//  Created by João Victor Mantese on 22/07/24.
//

import Foundation

struct Movie: Decodable {
    let id: Int
    let title: String
    let image: String
    let synopsis: String
    let rate: Double
    let releaseDate: String
}
