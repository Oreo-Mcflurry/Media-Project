//
//  MaskedImageView.swift
//  Media Project
//
//  Created by A_Mcflurry on 2/2/24.
//

import UIKit
import SnapKit

class MaskedImageView: UIImageView {

	override init(frame: CGRect) {
		super.init(frame: frame)
		configureView()
	}

	required init?(coder: NSCoder) {
		fatalError()
	}

	func configureView() {
		let gradientViewFrame = CGRect(x: 0, y: 0, width: Int(UIScreen.main.bounds.width), height: 200)
		layer.masksToBounds = true
		addGradient(frame: gradientViewFrame)
		contentMode = .scaleAspectFill

	}
}
