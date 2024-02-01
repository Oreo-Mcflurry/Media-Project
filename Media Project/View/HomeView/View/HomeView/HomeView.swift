//
//  HomeView.swift
//  Media Project
//
//  Created by A_Mcflurry on 2/1/24.
//

import UIKit
import SnapKit

class HomeView: BaseUIView {

	let searchBar = UISearchBar()
	let label = UILabel()
	let recommandCollectionView = RecommandingView()

	override func configureHierarchy() {
		[searchBar, label, recommandCollectionView].forEach { addSubview($0) }
	}

	override func configureLayout() {
		searchBar.snp.makeConstraints {
			$0.top.equalTo(self.safeAreaLayoutGuide)
			$0.horizontalEdges.equalTo(self).inset(5)
			$0.height.equalTo(45)
		}

		label.snp.makeConstraints {
			$0.top.equalTo(searchBar.snp.bottom).offset(10)
			$0.horizontalEdges.equalTo(self).inset(15)
		}

		recommandCollectionView.snp.makeConstraints {
			$0.top.equalTo(label.snp.bottom).offset(10)
			$0.horizontalEdges.bottom.equalTo(self)
		}

	}

	override func configureView() {
		searchBar.placeholder = "검색해보세요"
		searchBar.searchBarStyle = .minimal
		searchBar.showsCancelButton = true
		label.font = .boldSystemFont(ofSize: 17)
		label.text = ""
	}
}

#Preview {
	HomeViewController()
}
