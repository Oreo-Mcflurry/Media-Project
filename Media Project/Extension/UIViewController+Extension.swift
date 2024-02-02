//
//  UIViewController+Extension.swift
//  Media Project
//
//  Created by A_Mcflurry on 2/2/24.
//

import UIKit

extension UIViewController {
	enum TransitionStyle {
		case present
		case presentNavigation
		case presentFullNavigation
		case push
	}

	func transition(_ viewController: UIViewController, withStyle style: TransitionStyle) {
		switch style {
		case .present:
			present(viewController, animated: true)
		case .presentNavigation:
			present(UINavigationController(rootViewController: viewController), animated: true)
		case .presentFullNavigation:
			let nav = UINavigationController(rootViewController: viewController)
			nav.modalPresentationStyle = .fullScreen
			present(nav, animated: true)
		case .push:
			navigationController?.pushViewController(viewController, animated: true)
		}
	}
}

extension UINavigationController {
	open override func viewWillLayoutSubviews() {
		navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
	}
}
