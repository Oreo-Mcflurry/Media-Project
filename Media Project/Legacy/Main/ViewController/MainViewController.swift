//
//  MainViewController.swift
//  Media Project
//
//  Created by A_Mcflurry on 1/30/24.
//

//import UIKit
//import SnapKit
//import Kingfisher
//
//class MainViewController: UIViewController {
//
//	let tableView = UITableView()
//	var tvInfo: [[ResponseResult]] = [[], [], []]
//	var selectTime: Time = .day
//	override func viewDidLoad() {
//		super.viewDidLoad()
//		view.backgroundColor = .systemBackground
//		setTableView()
//		configureHierarchy()
//		configureView()
//		configureLayout()
//		let allCase = TMDBManager.TVKind.allCases
//
//		for (index, item) in allCase.enumerated() {
//			TMDBManager.getTVInfo(withKind: item, selectTime) { result in
//				self.tvInfo[index].append(contentsOf: result)
//				self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
//			}
//		}
////		TMDBManager.getTVTrend(selectTime) { result in
////			self.tvInfo[0].append(contentsOf: result)
////			self.tableView.reloadData()
////		}
////
////		TMDBManager.getTVTopRate { result in
////			self.tvInfo[1].append(contentsOf: result)
////			self.tableView.reloadData()
////		}
////
////		TMDBManager.getTVPopular { result in
////			self.tvInfo[2].append(contentsOf: result)
////			self.tableView.reloadData()
////		}
//	}
//}
//
//extension MainViewController: ConfigureView {
//	func configureHierarchy() {
//		[tableView].forEach { view.addSubview($0) }
//	}
//	
//	func configureLayout() {
//		tableView.snp.makeConstraints {
//			$0.edges.equalTo(view.snp.edges)
//		}
//	}
//	
//	func configureView() {
//		navigationItem.title = "TV쇼"
//		let rightButton = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(setTime))
//		navigationItem.rightBarButtonItem = rightButton
//	}
//
//	@objc func setTime() {
//		let alert =	UIAlertController(title: "TV쇼 뭘로 할지", message: "정해용", preferredStyle: .actionSheet)
//		let cancelButton = UIAlertAction(title: "취소", style: .cancel)
//		alert.addAction(cancelButton)
//
//		for item in Time.allCases {
//			let button = UIAlertAction(title: item.rawValue, style: .default) { _ in
//				self.selectTime = item
//				// TODO: 여기서 문제가 생기는데 이유가 뭔지 모르겠음.
//				TMDBManager.getTVInfo(withKind: .trend, item) { result in
//					self.tvInfo[0] = result
//					self.tableView.reloadData()
//				}
//			}
//			alert.addAction(button)
//		}
//
//		present(alert, animated: true)
//	}
//}
//
//extension MainViewController: UITableViewDelegate, UITableViewDataSource {
//	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//		return tvInfo.count
//	}
//	
//	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//		let cell = tableView.dequeueReusableCell(withIdentifier: TVTableViewCell.identifier, for: indexPath) as! TVTableViewCell
//		cell.collectionView.dataSource = self
//		cell.collectionView.delegate = self
//		cell.collectionView.tag = indexPath.row
//		cell.collectionView.register(TVCollectionViewCell.self, forCellWithReuseIdentifier: TVCollectionViewCell.identifier)
//		cell.collectionView.reloadItems(at: [indexPath])
//		return cell
//	}
//	
//	func setTableView() {
//		tableView.delegate = self
//		tableView.dataSource = self
//		tableView.register(TVTableViewCell.self, forCellReuseIdentifier: TVTableViewCell.identifier)
//		tableView.rowHeight = 200
//	}
//}
//
//extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//		return tvInfo[collectionView.tag].count
//	}
//	
//	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVCollectionViewCell.identifier, for: indexPath) as! TVCollectionViewCell
//		if let url = tvInfo[collectionView.tag][indexPath.item].posterPath {
//			cell.imageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(url)")!)
//		} else {
//			cell.imageView.kf.setImage(with: URL(string: TMDBManager.failImage)!)
//		}
//		cell.label.text = tvInfo[collectionView.tag][indexPath.item].name
//		return cell
//	}
//}
