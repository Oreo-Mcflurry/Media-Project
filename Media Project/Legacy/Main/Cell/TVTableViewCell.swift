//
//  TVTableViewCell.swift
//  Media Project
//
//  Created by A_Mcflurry on 1/30/24.
//

//import UIKit
//import SnapKit
//
//class TVTableViewCell: UITableViewCell {
//
//	lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: setCollectionViewLayout())
//
//	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//		super.init(style: style, reuseIdentifier: reuseIdentifier)
//		configureHierarchy()
//		configureLayout()
//		configureView()
//	}
//
//	required init?(coder: NSCoder) {
//		fatalError()
//	}
//
//	func setCollectionViewLayout() -> UICollectionViewLayout {
//		let layout = UICollectionViewFlowLayout()
//		layout.itemSize = CGSize(width: 150, height: 200)
//		layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
//		layout.minimumLineSpacing = 10
//		layout.minimumInteritemSpacing = 10
//		layout.scrollDirection = .horizontal
//		return layout
//	}
//}
//
//extension TVTableViewCell: ConfigureView {
//	func configureHierarchy() {
//		contentView.addSubview(collectionView)
//	}
//	
//	func configureLayout() {
//		collectionView.snp.makeConstraints {
//			$0.edges.equalTo(contentView.snp.edges)
//		}
//	}
//	
//	func configureView() {
//		collectionView.backgroundColor = .clear
//	}
//}
