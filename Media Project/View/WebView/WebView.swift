//
//  WebView.swift
//  Media Project
//
//  Created by A_Mcflurry on 2/1/24.
//

import UIKit
import SnapKit
import WebKit

class WebView: BaseUIView {
	var webView = WKWebView()

	override func configureHierarchy() {
		addSubview(webView)
	}

	override func configureLayout() {
		webView.snp.makeConstraints {
			$0.edges.equalTo(self)
		}
	}
}

//if let url = URL(string: url) {
//	let request = URLRequest(url: url)
//	webView.load(request)
//}
