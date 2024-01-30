//
//  IdentifierProtocolk.swift
//  Media Project
//
//  Created by A_Mcflurry on 1/30/24.
//

import UIKit

protocol ReusableViewProtocol {
	static var identifier: String { get }
}

extension UITableViewCell: ReusableViewProtocol {
	static var identifier: String {
		return String(describing: self)
	}
}

extension UICollectionReusableView: ReusableViewProtocol {
	static var identifier: String {
		return String(describing: self)
	}
}

extension UIViewController: ReusableViewProtocol {
	static var identifier: String {
		return String(describing: self)
	}
}
