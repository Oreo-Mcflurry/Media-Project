//
//  RecommandingView.swift
//  Media Project
//
//  Created by A_Mcflurry on 2/1/24.
//

import UIKit
import SnapKit

class RecommandingView: BaseUIView {
	let collectionView = UICollectionView(frame: .zero, collectionViewLayout: getCollectionViewLayout())

	override func configureHierarchy() {
		[collectionView].forEach { addSubview($0) }
	}

	override func configureLayout() {

		collectionView.snp.makeConstraints {
			$0.edges.equalTo(self)
		}
	}

	override func configureView() {
		collectionView.backgroundColor = .clear
	}

	private static func getCollectionViewLayout() -> UICollectionViewLayout {
		let layout = UICollectionViewFlowLayout()
		let padding: CGFloat = 15
		layout.itemSize = CGSize(width: (UIScreen.main.bounds.width-padding*4)/3, height: (UIScreen.main.bounds.width-padding*4)/2)
		layout.sectionInset = UIEdgeInsets(top: 0, left: padding, bottom: padding, right: padding)
		layout.minimumLineSpacing = padding
		layout.minimumInteritemSpacing = padding
		return layout
	}
}
