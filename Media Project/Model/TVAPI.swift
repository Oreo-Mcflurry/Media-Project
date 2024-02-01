//
//  Trend.swift
//  Media Project
//
//  Created by A_Mcflurry on 1/30/24.
//

import Foundation

struct TMDB: Decodable {
	let page: Int
	let results: [ResponseResult]
	let totalPages: Int
	let totalResults: Int

	enum CodingKeys: String, CodingKey {
		case page = "page"
		case results = "results"
		case totalPages = "total_pages"
		case totalResults = "total_results"
	}
}


struct ResponseResult: Decodable {
	let adult: Bool
	let backdropPath: String
	let genreIDS: [Int]
	let id: Int
	let originCountry: [String]
	let originalLanguage, originalName, overview: String
	let popularity: Double
	let posterPath: String
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

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.adult = try container.decode(Bool.self, forKey: .adult)
		self.backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath) ?? ""
		self.genreIDS = try container.decode([Int].self, forKey: .genreIDS)
		self.id = try container.decode(Int.self, forKey: .id)
		self.originCountry = try container.decode([String].self, forKey: .originCountry)
		self.originalLanguage = try container.decode(String.self, forKey: .originalLanguage)
		self.originalName = try container.decode(String.self, forKey: .originalName)
		self.overview = try container.decode(String.self, forKey: .overview)
		self.popularity = try container.decode(Double.self, forKey: .popularity)
		self.posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath) ?? ""
		self.firstAirDate = try container.decode(String.self, forKey: .firstAirDate)
		self.name = try container.decode(String.self, forKey: .name)
		self.voteAverage = try container.decode(Double.self, forKey: .voteAverage)
		self.voteCount = try container.decode(Int.self, forKey: .voteCount)
	}
}
