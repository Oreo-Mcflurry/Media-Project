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
	let isBest: Bool

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
		self.adult = try container.decodeIfPresent(Bool.self, forKey: .adult) ?? false
		self.backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath) ?? ""
		self.genreIDS = try container.decodeIfPresent([Int].self, forKey: .genreIDS) ?? []
		self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
		self.originCountry = try container.decodeIfPresent([String].self, forKey: .originCountry) ?? []
		self.originalLanguage = try container.decodeIfPresent(String.self, forKey: .originalLanguage) ?? "정보가 없습니다."
		self.originalName = try container.decodeIfPresent(String.self, forKey: .originalName) ?? "이름이 없습니다."
		self.overview = try container.decodeIfPresent(String.self, forKey: .overview) ?? "설명이 없습니다."
		self.popularity = try container.decodeIfPresent(Double.self, forKey: .popularity) ?? 0
		self.posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath) ?? ""
		self.firstAirDate = try container.decodeIfPresent(String.self, forKey: .firstAirDate) ?? ""
		self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? "이름이 없습니다."
		self.voteAverage = try container.decodeIfPresent(Double.self, forKey: .voteAverage) ?? 0
		self.voteCount = try container.decodeIfPresent(Int.self, forKey: .voteCount) ?? 0
		self.isBest = (try container.decode(Double.self, forKey: .voteAverage)) >= 8.0 ? true : false
	}
}
