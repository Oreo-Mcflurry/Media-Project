//
//  DetailView.swift
//  Media Project
//
//  Created by A_Mcflurry on 2/2/24.
//

import UIKit
import SnapKit
import Kingfisher

class DetailView: BaseUIView {
	let maskBackImageView = MaskedImageView(frame: .zero)
	let posterImageView = UIImageView()

	let scrollView = UIScrollView()

	let titleLabel = UILabel()
	let subtitleLabel = UILabel()
	let ratingLabel = UILabel()
	private let overviewLabel = UILabel()
	let descriptionLabel = UILabel()
	private let anotherPosterLabel = UILabel()

	let anotherPosterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: getCollectionViewLayout())

	override func configureHierarchy() {
		addSubview(scrollView)
		[maskBackImageView, posterImageView, titleLabel, subtitleLabel, ratingLabel, overviewLabel, descriptionLabel, anotherPosterLabel, anotherPosterCollectionView].forEach { addSubview($0) }
	}

	override func configureLayout() {
		scrollView.snp.makeConstraints {
			$0.edges.equalTo(self)
		}

		maskBackImageView.snp.makeConstraints {
			$0.top.horizontalEdges.equalTo(scrollView)
			$0.height.equalTo(200)
		}

		posterImageView.snp.makeConstraints {
			$0.top.equalTo(maskBackImageView.snp.bottom).inset(100)
			$0.trailing.equalTo(maskBackImageView).inset(20)
			$0.width.equalTo(130)
			$0.height.equalTo(200)
		}

		ratingLabel.snp.makeConstraints {
			$0.bottom.equalTo(posterImageView.snp.bottom)
			$0.leading.equalTo(self).inset(20)
			$0.trailing.equalTo(posterImageView.snp.leading).offset(-20)
			$0.height.equalTo(25)
		}

		subtitleLabel.snp.makeConstraints {
			$0.bottom.equalTo(ratingLabel.snp.top).offset(-10)
			$0.horizontalEdges.equalTo(ratingLabel)
			$0.height.equalTo(ratingLabel)
		}

		titleLabel.snp.makeConstraints {
			$0.bottom.equalTo(subtitleLabel.snp.top)
			$0.horizontalEdges.equalTo(subtitleLabel)
			$0.height.equalTo(40)
		}

		overviewLabel.snp.makeConstraints {
			$0.top.equalTo(posterImageView.snp.bottom).offset(20)
			$0.horizontalEdges.equalTo(self).inset(20)
			$0.height.equalTo(ratingLabel)
		}
		
		descriptionLabel.snp.makeConstraints {
			$0.top.equalTo(overviewLabel.snp.bottom).offset(10)
			$0.horizontalEdges.equalTo(self).inset(20)
		}

		anotherPosterLabel.snp.makeConstraints {
			$0.top.equalTo(descriptionLabel.snp.bottom).offset(20)
			$0.horizontalEdges.equalTo(self).inset(20)
		}

		anotherPosterCollectionView.snp.makeConstraints {
			$0.top.equalTo(anotherPosterLabel.snp.bottom).offset(10)
			$0.horizontalEdges.equalTo(self)
			$0.height.equalTo((UIScreen.main.bounds.width-20*4)/2)
		}
	}

	override func configureView() {
		[titleLabel, subtitleLabel, ratingLabel, overviewLabel, descriptionLabel].forEach {
			$0.textAlignment = .left
		}
		titleLabel.font = .boldSystemFont(ofSize: 30)
		descriptionLabel.numberOfLines = 0
		overviewLabel.text = "줄거리"
		anotherPosterLabel.text = "이 영화의 다른 포스터"
		[overviewLabel, descriptionLabel, subtitleLabel, anotherPosterLabel].forEach {
			$0.font = .systemFont(ofSize: 14)
			$0.textColor = .darkGray
		}

		posterImageView.isUserInteractionEnabled = true
		posterImageView.clipsToBounds = true
		posterImageView.layer.cornerRadius = 10
	}

	private static func getCollectionViewLayout() -> UICollectionViewLayout {
		let layout = UICollectionViewFlowLayout()
		let padding: CGFloat = 20
		layout.itemSize = CGSize(width: (UIScreen.main.bounds.width-padding*4)/3, height: (UIScreen.main.bounds.width-padding*4)/2)
		layout.sectionInset = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
		layout.minimumLineSpacing = padding
		layout.minimumInteritemSpacing = padding
		layout.scrollDirection = .horizontal
		return layout
	}
}

#Preview {
	DetailViewController()
}
