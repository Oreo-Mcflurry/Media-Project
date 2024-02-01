//
//  BaseCollectionViewCell.swift
//  Media Project
//
//  Created by A_Mcflurry on 2/1/24.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {

	override init(frame: CGRect) {
		super.init(frame: frame)
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
