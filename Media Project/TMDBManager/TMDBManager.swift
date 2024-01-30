//
//  TMDBManager.swift
//  Media Project
//
//  Created by A_Mcflurry on 1/30/24.
//

import Foundation
import Alamofire

class TMDBManager {
	static let header: HTTPHeaders = ["Authorization": APIKeys.auth]

	static func getTVTrend(_ time: Time, _ completionHandler: @escaping ([ResponseResult])->Void) {
		let url = "https://api.themoviedb.org/3/trending/tv/\(time.rawValue)"

		AF.request(url, headers: TMDBManager.header).responseDecodable(of: TVAPI.self) { result in
			switch result.result {
			case .success(let success):
				completionHandler(success.results)
			case .failure(let failure):
				dump(failure)
			}
		}
	}

	static func getTVTopRate(_ completionHandler: @escaping ([ResponseResult])->Void) {
		let url = "https://api.themoviedb.org/3/tv/top_rated"

		AF.request(url, headers: TMDBManager.header).responseDecodable(of: TVAPI.self) { result in
			switch result.result {
			case .success(let success):
				completionHandler(success.results)
			case .failure(let failure):
				dump(failure)
			}
		}
	}

	static func getTVPopular(_ completionHandler: @escaping ([ResponseResult])->Void) {
		let url = "https://api.themoviedb.org/3/tv/popular?language=ko-KR"

		AF.request(url, headers: TMDBManager.header).responseDecodable(of: TVAPI.self) { result in
			switch result.result {
			case .success(let success):
				completionHandler(success.results)

			case .failure(let failure):
				dump(failure)
			}
		}
	}
}

enum Time: String {
	case day
	case week
}
