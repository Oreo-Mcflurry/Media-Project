//
//  SearchHistoryCell.swift
//  Media Project
//
//  Created by A_Mcflurry on 2/1/24.
//

import UIKit
import SnapKit

class SearchingCell: BaseTableViewCell {
	let searchLabel = UILabel()

	override func configureHierarchy() {
		addSubview(searchLabel)
	}

	override func configureLayout() {
		searchLabel.snp.makeConstraints {
			$0.verticalEdges.equalTo(self).inset(10)
			$0.horizontalEdges.equalTo(self).inset(20)
			$0.height.equalTo(30)
		}
	}

	override func configureView() {
		searchLabel.font = .systemFont(ofSize: 15)
	}
}
