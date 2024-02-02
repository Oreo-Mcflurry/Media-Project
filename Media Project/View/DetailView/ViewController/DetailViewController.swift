//
//  DetailViewController.swift
//  Media Project
//
//  Created by A_Mcflurry on 2/2/24.
//

import UIKit
import Kingfisher

class DetailViewController: BaseViewController {

	let detailView = DetailView()
	var data: ResponseResult = .init()

	override func loadView() {
		self.view = detailView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func configureView() {
		detailView.posterImageView.kf.setImage(with: TMDBManager.getImageURL(data.posterPath))
		detailView.maskBackImageView.kf.setImage(with: TMDBManager.getImageURL(data.backdropPath))
		detailView.titleLabel.text = data.name
		detailView.subtitleLabel.text = data.originalName
		detailView.ratingLabel.text = "★ \(data.voteAverage)"
		detailView.descriptionLabel.text = data.overview
	}
}

#Preview {
	DetailViewController()
}
