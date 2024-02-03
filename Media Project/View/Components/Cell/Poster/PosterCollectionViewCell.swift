//
//  CollectionViewCell.swift
//  Media Project
//
//  Created by A_Mcflurry on 2/1/24.
//

import UIKit
import SnapKit

class PosterCollectionViewCell: BaseCollectionViewCell {
	let posterImage = UIImageView()
	let bestImage = UIImageView()
	var isBest = false {
		didSet {
			if self.isBest {
				addSubview(bestImage)
				bestImage.snp.makeConstraints {
					$0.top.trailing.equalTo(self)
					$0.leading.greaterThanOrEqualTo(self)
					$0.height.equalTo(self.frame.height/4)
					$0.width.equalTo(self.frame.width/2)
				}
			}
		}
	}

	override func configureHierarchy() {
		addSubview(posterImage)
	}

	override func configureLayout() {
		posterImage.snp.makeConstraints {
			$0.edges.equalTo(self)
		}
	}

	override func configureView() {
		bestImage.image = .best
		posterImage.contentMode = .scaleAspectFit
		posterImage.clipsToBounds = true
		posterImage.layer.cornerRadius = 10
		posterImage.isUserInteractionEnabled = true
		self.backgroundColor = .clear
			}
}
