//
//  TMDBManager.swift
//  Media Project
//
//  Created by A_Mcflurry on 1/30/24.
//

import Foundation
import Alamofire

class TMDBManager {
	static func requestTMDB(withAPI api: TMDBAPI, _ completionHandler: @escaping (TMDB)->Void) {
		AF.request(api.getURL,
					  method: api.method,
					  parameters: api.parameter,
					  encoding: api.encoding,
					  headers: api.header).responseDecodable(of: TMDB.self) { response in
			switch response.result {
			case .success(let success):
				completionHandler(success)
			case .failure(let fail):
				print(fail)
			}
		}
	}

	static func getImageURL(_ url: String) -> URL {
		if url.isEmpty {
			return URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFRFhuWTMRBoq0dYcS9QyI8ivHbHkCsmfV1GRbQeKMcg&s")!
		} else {
			return URL(string: "https://image.tmdb.org/t/p/w500\(url)")!
		}
	}
}



// 데이터를 공유하지 않아서 굳이 싱글톤을 쓸필요가 없다는 생각에, 싱글톤을 제외하고 Static으로만 구성해봤어요.
// 그러나 서브스크립트를 도입하면서 이 TMDBManger의 실효성에 대해 의문점이 생기게 되었어요.
// 이정도면... 그냥 인스턴스를 만드는게 낫지 않을까 라는 생각이... 계속 들기도 하고 그러는군요.
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
