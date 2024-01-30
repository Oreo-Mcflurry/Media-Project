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
	let name: String
	let posterPath: String?

	enum CodingKeys: String, CodingKey {
		case name
		case posterPath = "poster_path"
	}
}
