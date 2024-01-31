//
//  Trend.swift
//  Media Project
//
//  Created by A_Mcflurry on 1/30/24.
//

import Foundation

struct TVAPI: Decodable {
	let results: [ResponseResult]

	enum CodingKeys: String, CodingKey {
		case results
	}
}


struct ResponseResult: Decodable {
	let adult: Bool
	let backdropPath: String?
	let genreIDS: [Int]
	let id: Int
	let originCountry: [String]
	let originalLanguage, originalName, overview: String
	let popularity: Double
	let posterPath: String?
	let firstAirDate, name: String
	let voteAverage: Double
	let voteCount: Int

	enum CodingKeys: String, CodingKey {
		case adult
		case backdropPath = "backdrop_path"
		case genreIDS = "genre_ids"
		case id
		case originCountry = "origin_country"
		case originalLanguage = "original_language"
		case originalName = "original_name"
		case overview, popularity
		case posterPath = "poster_path"
		case firstAirDate = "first_air_date"
		case name
		case voteAverage = "vote_average"
		case voteCount = "vote_count"
	}
}
