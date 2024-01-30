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
	static let failImage: String = "https://search.pstatic.net/common/?src=http%3A%2F%2Fpost.phinf.naver.net%2FMjAxOTA2MjVfNCAg%2FMDAxNTYxNDUyNjU1NDIy.5vpE1pW3ouD-TCcIwlArOElz-m8FhsPZX71hJEtM794g.MI95E9iXt_QmwgXFHrxEa1nCm98SU1Y0VC9pbFYd5yog.JPEG%2FIugzStc1p_N0_ijIuWK08xf-gjJg.jpg&type=sc960_832"

	enum TVKind: String, CaseIterable {
		case trend
		case topRate
		case popular
	}

	static func getTVInfo(withKind kind: TVKind, _ time: Time?, _ completionHandler: @escaping ([ResponseResult])->Void) {
		let url: String
		switch kind {
		case .trend: url = "https://api.themoviedb.org/3/trending/tv/\(time?.rawValue ?? Time.day.rawValue)"
		case .topRate: url = "https://api.themoviedb.org/3/tv/top_rated"
		case .popular: url = "https://api.themoviedb.org/3/tv/popular?language=ko-KR"
		}


		AF.request(url, headers: TMDBManager.header).responseDecodable(of: TVAPI.self) { result in
			switch result.result {
			case .success(let success):
				completionHandler(success.results)
			case .failure(let failure):
				dump(failure)
			}
		}
	}

//	static func getTVTopRate(_ completionHandler: @escaping ([ResponseResult])->Void) {
//
//		AF.request(url, headers: TMDBManager.header).responseDecodable(of: TVAPI.self) { result in
//			switch result.result {
//			case .success(let success):
//				completionHandler(success.results)
//			case .failure(let failure):
//				dump(failure)
//			}
//		}
//	}
//
//	static func getTVPopular(_ completionHandler: @escaping ([ResponseResult])->Void) {
//		AF.request(url, headers: TMDBManager.header).responseDecodable(of: TVAPI.self) { result in
//			switch result.result {
//			case .success(let success):
//				completionHandler(success.results)
//
//			case .failure(let failure):
//				dump(failure)
//			}
//		}
//	}
}

enum Time: String, CaseIterable {
	case day
	case week
}


