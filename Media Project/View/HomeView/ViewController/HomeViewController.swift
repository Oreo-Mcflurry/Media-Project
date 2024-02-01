//
//  HomeViewController.swift
//  Media Project
//
//  Created by A_Mcflurry on 2/1/24.
//

import UIKit
import Kingfisher
import Toast

class HomeViewController: BaseViewController {

	var trendResult: TMDB = .init(page: 0, results: [], totalPages: 0, totalResults: 0)
	var searchResult: TMDB = .init(page: 0, results: [], totalPages: 0, totalResults: 0)
	let homeView = HomeView()
	var selectedTime: TMDBAPI.Time = .day

	override func loadView() {
		self.view = homeView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setCollectionView()
		setSearchbar()
		setTableView()
		requestTMDB()
	}

	override func configureView() {
		let rightButton = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(changeTime))
		rightButton.tintColor = .black
		navigationItem.rightBarButtonItem = rightButton

		navigationItem.title = "SeSAC 영화관"

//		let endEditGesture = UITapGestureRecognizer(target: self, action: #selector(endEdit))
//		view.addGestureRecognizer(endEditGesture)
	}

	@objc func changeTime() {
		selectedTime = selectedTime == .day ? .week : .day
		let toastMessage = selectedTime == .day ? "오늘의" : "이번주의"
		view.makeToast("\(toastMessage) 핫한 영화 추천으로 변경하였습니다.")
		requestTMDB()
	}

	@objc func endEdit() {
		view.endEditing(true)
	}

	private func requestTMDB() {
		TMDBManager.requestTMDB(withAPI: .trending(time: selectedTime)) { result in
			self.trendResult = result
			self.homeView.recommandCollectionView.collectionView.reloadData()
		}
		homeView.recommandCollectionView.label.text = selectedTime == .day ? "오늘의 핫한 영화" : "이번주의 핫한 영화"
	}
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return searchResult.results.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: SearchingCell.identifier, for: indexPath) as! SearchingCell
		cell.searchLabel.text = searchResult.results[indexPath.row].name
		return cell
	}

	func setTableView() {
		homeView.searchView.tableView.dataSource = self
		homeView.searchView.tableView.delegate = self
		homeView.searchView.tableView.register(SearchingCell.self, forCellReuseIdentifier: SearchingCell.identifier)
	}
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return trendResult.results.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as! PosterCollectionViewCell
		cell.posterImage.kf.setImage(with: TMDBManager.getImageURL(trendResult.results[indexPath.item].posterPath))
		cell.isBest = trendResult.results[indexPath.item].isBest
		return cell
	}

	func setCollectionView() {
		homeView.recommandCollectionView.collectionView.delegate = self
		homeView.recommandCollectionView.collectionView.dataSource = self
		homeView.recommandCollectionView.collectionView.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
	}
}

extension HomeViewController: UISearchBarDelegate {
	func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
		searchResult.results.removeAll()
		homeView.searchView.tableView.reloadData()
		homeView.recommandCollectionView.removeFromSuperview()
		homeView.addSubview(homeView.searchView)
		homeView.setSearchTableViewLayout()
	}

	func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
		homeView.searchView.removeFromSuperview()
		homeView.addSubview(homeView.recommandCollectionView)
		homeView.setRecommandCollectionViewLayout()
	}

	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		TMDBManager.requestTMDB(withAPI: .search(query: searchBar.text!)) { result in
			self.searchResult = result
			self.homeView.searchView.tableView.reloadData()
		}
	}

	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		endEdit()
	}

	func setSearchbar() {
		homeView.searchBar.delegate = self
	}
}

#Preview {
	HomeViewController()
}
