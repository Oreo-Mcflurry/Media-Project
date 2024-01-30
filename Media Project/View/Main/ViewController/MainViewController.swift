//
//  MainViewController.swift
//  Media Project
//
//  Created by A_Mcflurry on 1/30/24.
//

import UIKit
import SnapKit
import Kingfisher

class MainViewController: UIViewController {

	let tableView = UITableView()
	var tvInfo: [[ResponseResult]] = [[], [], []]
	var selectTime: Time = .day
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		setTableView()
		configureHierarchy()
		configureView()
		configureLayout()
		TMDBManager.getTVTrend(selectTime) { result in
			self.tvInfo[0].append(contentsOf: result)
			self.tableView.reloadData()
		}

		TMDBManager.getTVTopRate { result in
			self.tvInfo[1].append(contentsOf: result)
			self.tableView.reloadData()
		}

		TMDBManager.getTVPopular { result in
			self.tvInfo[2].append(contentsOf: result)
			self.tableView.reloadData()
		}
	}
}

extension MainViewController: ConfigureView {
	func configureHierarchy() {
		[tableView].forEach { view.addSubview($0) }
	}
	
	func configureLayout() {
		tableView.snp.makeConstraints {
			$0.edges.equalTo(view.snp.edges)
		}
	}
	
	func configureView() {
		navigationItem.title = "TV쇼"
	}
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tvInfo.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: TVTableViewCell.identifier, for: indexPath) as! TVTableViewCell
		cell.collectionView.dataSource = self
		cell.collectionView.delegate = self
		cell.collectionView.tag = indexPath.row
		cell.collectionView.register(TVCollectionViewCell.self, forCellWithReuseIdentifier: TVCollectionViewCell.identifier)
		cell.collectionView.reloadData()
		return cell
	}
	
	func setTableView() {
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(TVTableViewCell.self, forCellReuseIdentifier: TVTableViewCell.identifier)
		tableView.rowHeight = 200
	}
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return tvInfo[collectionView.tag].count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVCollectionViewCell.identifier, for: indexPath) as! TVCollectionViewCell
		if let url = tvInfo[collectionView.tag][indexPath.item].posterPath {
			cell.imageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(url)")!)
		} else {
			cell.imageView.kf.setImage(with: URL(string: "https://search.pstatic.net/common/?src=http%3A%2F%2Fpost.phinf.naver.net%2FMjAxOTA2MjVfNCAg%2FMDAxNTYxNDUyNjU1NDIy.5vpE1pW3ouD-TCcIwlArOElz-m8FhsPZX71hJEtM794g.MI95E9iXt_QmwgXFHrxEa1nCm98SU1Y0VC9pbFYd5yog.JPEG%2FIugzStc1p_N0_ijIuWK08xf-gjJg.jpg&type=sc960_832")!)
		}
		cell.label.text = tvInfo[collectionView.tag][indexPath.item].name
		return cell
	}
}
