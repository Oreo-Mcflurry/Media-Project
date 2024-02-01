//
//  SearchTableViewCell.swift
//  Media Project
//
//  Created by A_Mcflurry on 1/31/24.
//

//import UIKit
//import SnapKit
//
//class SearchTableViewCell: BaseTableViewCell {
//
//	let dramaLabel: UILabel = {
//		let view = UILabel()
//		view.font = .systemFont(ofSize: 16)
//		return view
//	}()
//
//	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//		super.init(style: style, reuseIdentifier: reuseIdentifier)
//	}
//
//	required init?(coder: NSCoder) {
//		fatalError()
//	}
//
//	override func configureHierarchy() {
//		contentView.addSubview(dramaLabel)
//	}
//
//	override func configureLayout() {
//		dramaLabel.snp.makeConstraints {
//			$0.verticalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(10)
//			$0.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(20)
//		}
//	}
//}
