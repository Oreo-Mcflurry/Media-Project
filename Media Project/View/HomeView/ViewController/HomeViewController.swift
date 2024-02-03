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

	var searchPage = 1
	var trendResult: TMDB = .init()
	var searchResult: TMDB = .init()
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
		TMDBManager.requestTMDB(withAPI: .trending(time: selectedTime), model: TMDB.self) { result in
			self.trendResult = result
			self.homeView.recommandCollectionView.collectionView.reloadData()
		}
		homeView.recommandCollectionView.label.text = selectedTime == .day ? "오늘의 핫한 영화" : "이번주의 핫한 영화"
	}
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
	func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
		if searchPage < searchResult.totalPages {
			for item in indexPaths where item.row >= searchResult.results.count - 3 {
				searchPage += 1
				TMDBManager.requestTMDB(withAPI: .search(query: homeView.searchBar.text!, page: searchPage), model: TMDB.self) { result in
					self.searchResult.results.append(contentsOf: result.results)
					self.homeView.searchView.tableView.reloadData()
				}
				break
			}
		}
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return searchResult.results.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: SearchingCell.identifier, for: indexPath) as! SearchingCell
		cell.searchLabel.text = searchResult.results[indexPath.row].name
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let vc = DetailViewController()
		vc.data = searchResult.results[indexPath.row]
		transition(vc, withStyle: .push)
	}

	func setTableView() {
		homeView.searchView.tableView.dataSource = self
		homeView.searchView.tableView.delegate = self
		homeView.searchView.tableView.prefetchDataSource = self
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

		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pushDetailView(sender:)))
		cell.posterImage.tag = indexPath.item
		cell.posterImage.addGestureRecognizer(tapGesture)
		return cell
	}

	func setCollectionView() {
		homeView.recommandCollectionView.collectionView.delegate = self
		homeView.recommandCollectionView.collectionView.dataSource = self
		homeView.recommandCollectionView.collectionView.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
	}

	@objc func pushDetailView(sender: UIGestureRecognizer) {
		let vc = DetailViewController()
		vc.data = trendResult.results[sender.view!.tag]
		transition(vc, withStyle: .push)
	}
}

extension HomeViewController: UISearchBarDelegate {
	func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
		homeView.recommandCollectionView.removeFromSuperview()
		homeView.addSubview(homeView.searchView)
		homeView.setSearchTableViewLayout()
		homeView.searchBar.setShowsCancelButton(true, animated: true)
	}

	func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
		homeView.searchView.removeFromSuperview()
		homeView.addSubview(homeView.recommandCollectionView)
		homeView.setRecommandCollectionViewLayout()
		homeView.searchBar.setShowsCancelButton(false, animated: true)
	}

	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		searchResult.results.removeAll()
		homeView.searchView.tableView.reloadData()
	}

	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		searchPage = 1
		TMDBManager.requestTMDB(withAPI: .search(query: searchBar.text!, page: searchPage), model: TMDB.self) { result in
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
