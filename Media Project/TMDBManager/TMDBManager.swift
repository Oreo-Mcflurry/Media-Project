//
//  TMDBManager.swift
//  Media Project
//
//  Created by A_Mcflurry on 1/30/24.
//

import Foundation
import Alamofire

// 데이터를 공유하지 않아서 굳이 싱글톤을 쓸필요가 없다는 생각에, 싱글톤을 제외하고 Static으로만 구성해봤어요.
// 그러나 서브스크립트를 도입하면서 이 TMDBManger의 실효성에 대해 의문점이 생기게 되었어요.
// 이정도면... 그냥 인스턴스를 만드는게 낫지 않을까 라는 생각이... 계속 들기도 하고 그러는군요.
class TMDBManager {

	subscript(url: String?) -> String {
		get {
			if let url {
				return "https://image.tmdb.org/t/p/w500\(url)"
			} else {
				return TMDBManager.failImage
			}
		}
	}

	static let header: HTTPHeaders = ["Authorization": APIKeys.auth]
	static let failImage: String = "https://search.pstatic.net/common/?src=http%3A%2F%2Fpost.phinf.naver.net%2FMjAxOTA2MjVfNCAg%2FMDAxNTYxNDUyNjU1NDIy.5vpE1pW3ouD-TCcIwlArOElz-m8FhsPZX71hJEtM794g.MI95E9iXt_QmwgXFHrxEa1nCm98SU1Y0VC9pbFYd5yog.JPEG%2FIugzStc1p_N0_ijIuWK08xf-gjJg.jpg&type=sc960_832"

	enum TVKind: String, CaseIterable {
		case trend
		case topRate
		case popular
	}

	static func getTVInfo(withKind kind: TVKind, _ time: Time, _ completionHandler: @escaping ([ResponseResult])->Void) {
		let url: String

		switch kind {
		case .trend: url = "https://api.themoviedb.org/3/trending/tv/\(time.rawValue)"
		case .topRate: url = "https://api.themoviedb.org/3/tv/top_rated"
		case .popular: url = "https://api.themoviedb.org/3/tv/popular?language=ko-KR"
			TMDBManager.request(url, completionHandler)
		}
	}

	static func searchTVInfo(withText text: String, _ completionHandler: @escaping ([ResponseResult])->Void) {
		let url = "https://api.themoviedb.org/3/search/tv?query=\(text)&include_adult=false&language=ko-KR&page=1"
		TMDBManager.request(url, completionHandler)
	}

	static func getTVRecommand(withId id: String, _ completionHandler: @escaping ([ResponseResult])->Void) {
		let url = "https://api.themoviedb.org/3/tv/\(id)/recommendations?language=ko-KR"
		TMDBManager.request(url, completionHandler)
	}

	static func getTVCredit(withId id: String, _ completionHandler: @escaping ([ResponseResult])->Void) {
		let url = "https://api.themoviedb.org/3/tv/\(id)/aggregate_credits"
		TMDBManager.request(url, completionHandler)
	}

	static func request(_ url: String, _ completionHandler: @escaping ([ResponseResult])->Void) {
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

enum Time: String, CaseIterable {
	case day
	case week
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
