//
//  UIView+Extension.swift
//  Media Project
//
//  Created by A_Mcflurry on 2/2/24.
//

import UIKit

extension UIView {
	 func addGradient(frame: CGRect) {
		  let gradientView = UIView(frame: self.frame)
		  let gradientLayer = CAGradientLayer()
		  gradientLayer.frame = frame
		  gradientLayer.colors = [UIColor.clear.cgColor, UIColor.systemBackground.cgColor]
		  gradientLayer.locations = [0.0, 1.0]
		  gradientView.layer.insertSublayer(gradientLayer, at: 0)
		  addSubview(gradientView)
	 }
}
