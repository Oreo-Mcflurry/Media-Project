//
//  Person.swift
//  Media Project
//
//  Created by A_Mcflurry on 2/6/24.
//

import Foundation

struct Person: Decodable {
	let id: Int
	let cast: [Cast]
}

struct Cast: Decodable {
	let name: String
	let originalName: String
	let profilePath: String
	let department: String

	enum CodingKeys: String, CodingKey {
		case name
		case originalName = "original_name"
		case profilePath = "profile_path"
		case department = "known_for_department"
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
		self.originalName = try container.decodeIfPresent(String.self, forKey: .originalName) ?? ""
		self.profilePath = try container.decodeIfPresent(String.self, forKey: .profilePath) ?? ""
		self.department = try container.decodeIfPresent(String.self, forKey: .department) ?? ""
	}

	init() {
		self.name = ""
		self.originalName = ""
		self.profilePath = ""
		self.department = ""
	}
}
