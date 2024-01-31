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

	var recommandInfo: [ResponseResult] = []

//	let scrollView = UIScrollView()
	let backImageView = UIImageView()

	let tableView = UITableView()

	let label: UILabel = {
		let label = UILabel()
		label.text = "이 드라마와 비슷한 드라마"
		return label
	}()
	override func viewDidLoad() {
		super.viewDidLoad()
		setTableView()
		TMDBManager.getTVRecommand(withId: "\(info.id)") { result in
			self.recommandInfo.append(contentsOf: result)
			self.tableView.reloadData()
		}
	}

	func setTableView() {
		tableView.dataSource = self
		tableView.delegate = self
		tableView.register(TVTableViewCell.self, forCellReuseIdentifier: TVTableViewCell.identifier)
		tableView.rowHeight = 200
	}

	override func configureHierarchy() {
//		view.addSubview(scrollView)
		view.addSubview(tableView)
		view.addSubview(backImageView)
		view.addSubview(label)
	}

	override func configureLayout() {
//		scrollView.snp.makeConstraints {
//			$0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
//			$0.bottom.equalTo(view.snp.bottom)
//		}

		backImageView.snp.makeConstraints {
			$0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
		}

		label.snp.makeConstraints {
			$0.top.equalTo(backImageView.snp.bottom).offset(10)
//			$0.top.equalTo(label.snp.bottom)
			$0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
		}

		tableView.snp.makeConstraints {
//			$0.edges.equalTo(view.snp.edges)
			$0.top.equalTo(label.snp.bottom).offset(10)
			$0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
			$0.bottom.equalTo(view.snp.bottom)
		}
	}

	override func configureView() {
		navigationItem.title = info.name

		backImageView.kf.setImage(with: URL(string: TMDBManager()[info.backdropPath])!)
		backImageView.contentMode = .scaleAspectFit
	}
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 2
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: TVTableViewCell.identifier, for: indexPath) as! TVTableViewCell
		cell.collectionView.delegate = self
		cell.collectionView.dataSource = self
		cell.collectionView.register(TVCollectionViewCell.self, forCellWithReuseIdentifier: TVCollectionViewCell.identifier)
		cell.collectionView.reloadData()
		return cell
	}

}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return recommandInfo.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVCollectionViewCell.identifier, for: indexPath) as! TVCollectionViewCell
		
		cell.imageView.kf.setImage(with: URL(string: TMDBManager()[recommandInfo[indexPath.item].posterPath])!)
		cell.label.text = recommandInfo[indexPath.item].name
		return cell
	}
}
