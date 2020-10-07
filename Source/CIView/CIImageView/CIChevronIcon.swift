//
//  CIChevronIcon.swift
//  ConvenientCell
//
//  Created by Feiyou Guo on 9/14/20.
//  Copyright © 2020 Exquisitian. All rights reserved.
//

import UIKit

public class CIChevronIcon: CIImageView {

	public init(tintColor: UIColor? = nil) {
		// Initialization
		let iconConfiguration = UIImage.SymbolConfiguration(weight: .medium)
		let chevronImage = UIImage(systemName: "chevron.right", withConfiguration: iconConfiguration)?
			.withRenderingMode(.alwaysTemplate)
		super.init(image: chevronImage, position: .Right)
		
		// General

		// Style
		self.tintColor = tintColor ?? .systemGray
		self.backgroundColor = .clear
		
		// Constraint
		NSLayoutConstraint.activate([
			self.widthAnchor.constraint(equalToConstant: 10),
			self.heightAnchor.constraint(equalToConstant: 15)
		], priority: .required)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
