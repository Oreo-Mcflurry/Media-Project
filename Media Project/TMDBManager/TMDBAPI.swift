//
//  TMDBAPI.swift
//  Media Project
//
//  Created by A_Mcflurry on 2/1/24.
//

import Foundation
import Alamofire

enum TMDBAPI {
	enum Time: String {
		case week
		case day
	}

	case trending(time: Time)
	case search(query: String, page: Int) // 열거형의 연관값
	case photo(id: String)

	private var baseURL: String {
		return "https://api.themoviedb.org/3/"
	}

	var getURL: URL {
		switch self {
		case .trending(let time):
			return URL(string: baseURL + "trending/movie/\(time.rawValue)?language=ko-KR")!
		case .search:
			return URL(string: baseURL + "search/movie")!
		case .photo(let id):
			return URL(string: baseURL + "movie/\(id)/images")!
		}
	}

	var header: HTTPHeaders {
		return ["Authorization": APIKeys.auth]
	}

	var method: HTTPMethod {
		return .get
	}

	var parameter: Parameters {
		switch self {
		case .trending:
			return ["":""]
		case .search(let query, let page):
			return ["query": query, "language": "ko-KR", "page": page]
		case .photo:
			return ["":""]
		}
	}

	var encoding: URLEncoding {
		switch self {
		case .trending: return .default

		case .search: return .queryString
		case .photo: return .default
		}
	}
}
