//
//  SearchTableVuew.swift
//  Media Project
//
//  Created by A_Mcflurry on 2/1/24.
//

import UIKit
import SnapKit

class SearchView: BaseUIView {
	let tableView = UITableView()

	override func configureHierarchy() {
		addSubview(tableView)
	}

	override func configureLayout() {
		tableView.snp.makeConstraints {
			$0.edges.equalTo(self)
		}
	}

	override func configureView() {
		tableView.backgroundColor = .clear
	}
}
