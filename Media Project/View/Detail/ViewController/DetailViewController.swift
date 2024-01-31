//
//  DetailViewController.swift
//  Media Project
//
//  Created by A_Mcflurry on 1/31/24.
//

import UIKit
import Kingfisher

class DetailViewController: BaseViewController {

	var info: ResponseResult = .init(adult: false, backdropPath: "", genreIDS: [], id: 0, originCountry: [], originalLanguage: "", originalName: "", overview: "", popularity: 0, posterPath: "", firstAirDate: "", name: "", voteAverage: 0, voteCount: 0)

	let scrollView = UIScrollView()
	let backImageView = UIImageView()
	let recommandCollectionView = UICollectionView()

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func configureHierarchy() {
		view.addSubview(scrollView)
		scrollView.addSubview(backImageView)
	}

	override func configureLayout() {
		scrollView.snp.makeConstraints {
			$0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
			$0.bottom.equalTo(view.snp.bottom)
		}

		backImageView.snp.makeConstraints {
			$0.top.verticalEdges.equalTo(0)
		}
	}

	override func configureView() {
		navigationItem.title = info.name

		backImageView.kf.setImage(with: URL(string: TMDBManager()[info.backdropPath])!)
		backImageView.contentMode = .scaleAspectFill
	}
}
