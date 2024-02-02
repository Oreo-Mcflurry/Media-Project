//
//  WebViewController.swift
//  Media Project
//
//  Created by A_Mcflurry on 2/1/24.
//

import UIKit

class WebViewController: BaseViewController {

	let webView = WebView()
	var url = ""

	override func loadView() {
		self.view = webView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func configureView() {
		if let url = URL(string: url) {
			let request = URLRequest(url: url)
			webView.webView.load(request)
		}
	}

	static func getURL(withQuery text: String) -> String {
		return "https://www.google.com/search?q=\(text)"
	}
}
