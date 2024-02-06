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
	case photo(id: Int)
	case similar(id: Int)
	case credit(id: Int)

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
		case .similar(let id):
			return URL(string: baseURL + "movie/\(id)/recommendations")!
		case .credit(let id):
			return URL(string: baseURL + "movie/\(id)/credits")!
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
			return [:]
		case .search(let query, let page):
			return ["query": query, "language": "ko-KR", "page": page]
		case .photo:
			return [:]
		case .similar:
			return ["language": "ko-KR", "page": "1"]
		case .credit:
			return ["language": "ko-KR"]
		}
	}

	var encoding: URLEncoding {
		switch self {
		case .trending: return .default
		case .search: return .queryString
		case .photo: return .default
		case .similar: return .queryString
		case .credit: return .queryString
		}
	}
}
