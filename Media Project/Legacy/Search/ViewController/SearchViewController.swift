//
//  SearchViewController.swift
//  Media Project
//
//  Created by A_Mcflurry on 1/31/24.
//

//import UIKit
//import SnapKit
//
//class SearchViewController: BaseViewController {
//
//	var searchResult: [ResponseResult] = []
//	lazy var searchBar: UISearchBar = {
//		let view = UISearchBar()
//		view.placeholder = "드라마를 검색해보세용"
//		view.delegate = self
//		return view
//	}()
//
//	lazy var tableView: UITableView = {
//		let view = UITableView()
//		view.delegate = self
//		view.dataSource = self
//		view.rowHeight = UITableView.automaticDimension
//		view.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
//		return view
//	}()
//
//	override func viewDidLoad() {
//		super.viewDidLoad()
//	}
//
//	override func configureHierarchy() {
//		[searchBar, tableView].forEach { view.addSubview($0) }
//	}
//
//
//	override func configureLayout() {
//		searchBar.snp.makeConstraints {
//			$0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
//			$0.height.equalTo(40)
//		}
//		tableView.snp.makeConstraints {
//			$0.top.equalTo(searchBar.snp.bottom)
//			$0.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
//		}
//	}
//
//	override func configureView() {
//		navigationItem.title = "검색"
//	}
//}
//
//extension SearchViewController: UISearchBarDelegate {
//	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//		TMDBManager.searchTVInfo(withText: searchBar.text!) { result in
//			self.searchResult = result
//			self.tableView.reloadData()
//		}
//	}
//}
//
//extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
//	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//		return searchResult.count
//	}
//	
//	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//		let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell
//		cell.dramaLabel.text = searchResult[indexPath.row].name
//		return cell
//	}
//
//	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//		let vc = DetailViewController()
//		vc.info = searchResult[indexPath.row]
//		navigationController?.pushViewController(vc, animated: true)
//	}
//}
