//
//  TVCollectionViewCell.swift
//  Media Project
//
//  Created by A_Mcflurry on 1/30/24.
//

import UIKit
import SnapKit

class TVCollectionViewCell: UICollectionViewCell {

	let label = UILabel()
	let imageView = UIImageView()

	override init(frame: CGRect) {
		super.init(frame: frame)
		configureHierarchy()
		configureLayout()
		configureView()
	}

	required init?(coder: NSCoder) {
		fatalError()
	}
}

extension TVCollectionViewCell: ConfigureView {
	func configureHierarchy() {
		[imageView, label].forEach { contentView.addSubview($0) }
	}
	
	func configureLayout() {
		imageView.snp.makeConstraints {
			$0.edges.equalTo(contentView.snp.edges)
		}

		label.snp.makeConstraints {
			$0.bottom.equalTo(contentView.snp.bottom).offset(-10)
			$0.horizontalEdges.equalTo(contentView.snp.horizontalEdges).inset(10)
		}
	}
	
	func configureView() {
		label.textAlignment = .center
		label.font = .boldSystemFont(ofSize: 15)
		label.backgroundColor = .white
	}
}
