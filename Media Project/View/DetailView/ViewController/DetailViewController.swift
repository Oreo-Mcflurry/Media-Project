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
	var postersData: [Poster] = .init()
	var creditsData: [Cast] = .init()

	override func loadView() {
		self.view = detailView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setCollectionView()
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewDetailInfoInGoogle))
		detailView.posterImageView.addGestureRecognizer(tapGesture)

		TMDBManager.requestTMDB(withAPI: .photo(id: data.id), model: PosterModel.self) { result in
			self.postersData = result.posters
			self.detailView.anotherPosterCollectionView.reloadData()
		}

		TMDBManager.requestTMDB(withAPI: .credit(id: data.id), model: Person.self) { result in
			self.creditsData = result.cast
			self.detailView.creditsCollectionView.reloadData()
		}
	}

	override func configureView() {
		detailView.posterImageView.kf.setImage(with: TMDBManager.getImageURL(data.posterPath))
		detailView.maskBackImageView.kf.setImage(with: TMDBManager.getImageURL(data.backdropPath))
		detailView.titleLabel.text = data.name
		detailView.subtitleLabel.text = data.originalName
		detailView.ratingLabel.text = "★ \(String(format: "%.1f", data.voteAverage))"
		detailView.descriptionLabel.text = data.overview
	}

	@objc func viewDetailInfoInGoogle() {
		let vc = WebViewController()
		vc.url = WebViewController.getURL(withQuery: data.name)
		vc.navigationItem.title = data.name
		transition(vc, withStyle: .push)
	}
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return postersData.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as! PosterCollectionViewCell

		let imageURL = collectionView == detailView.anotherPosterCollectionView ? postersData[indexPath.item].file_path : creditsData[indexPath.item].profilePath
		let gesture: Selector = collectionView == detailView.anotherPosterCollectionView ? #selector(viewPosterDetail(sender:)) : #selector(viewPersonDetail(sender:))

		let tapGesture = UITapGestureRecognizer(target: self, action: gesture)
		cell.posterImage.addGestureRecognizer(tapGesture)
		cell.posterImage.kf.setImage(with: TMDBManager.getImageURL(imageURL))

		cell.posterImage.tag = indexPath.item
		cell.posterImage.isUserInteractionEnabled = true


		return cell
	}
	
	func setCollectionView() {
		detailView.anotherPosterCollectionView.delegate = self
		detailView.anotherPosterCollectionView.dataSource = self
		detailView.anotherPosterCollectionView.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)

		detailView.creditsCollectionView.delegate = self
		detailView.creditsCollectionView.dataSource = self
		detailView.creditsCollectionView.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
	}

	@objc func viewPosterDetail(sender: UITapGestureRecognizer) {
		let vc = WebViewController()
		vc.url = TMDBManager.getImageURL(postersData[sender.view!.tag].file_path)
		transition(vc, withStyle: .present)
	}

	@objc func viewPersonDetail(sender: UITapGestureRecognizer) {
		let vc = WebViewController()
		vc.url = WebViewController.getURL(withQuery: creditsData[sender.view!.tag].originalName)
		vc.navigationItem.title = creditsData[sender.view!.tag].originalName
		transition(vc, withStyle: .push)
	}
}

#Preview {
	DetailViewController()
}
