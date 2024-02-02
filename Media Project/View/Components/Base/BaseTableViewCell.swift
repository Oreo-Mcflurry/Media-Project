//
//  SearchTableViewCell.swift
//  Media Project
//
//  Created by A_Mcflurry on 1/31/24.
//

import UIKit

class BaseTableViewCell: UITableViewCell, ConfigureView {

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		contentView.backgroundColor = .systemBackground
		configureHierarchy()
		configureLayout()
		configureView()
	}

	required init?(coder: NSCoder) {
		fatalError()
	}

	func configureHierarchy() {

	}

	func configureLayout() {

	}

	func configureView() {

	}
}
