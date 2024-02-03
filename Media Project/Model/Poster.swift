//
//  Poster.swift
//  Media Project
//
//  Created by A_Mcflurry on 2/3/24.
//

import Foundation

struct PosterModel: Decodable {
	let posters: [Poster]
}

struct Poster: Decodable {
	let file_path: String
}
