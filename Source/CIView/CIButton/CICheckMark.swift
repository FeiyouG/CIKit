//
//  CICheckMark.swift
//  CITableViewCell
//
//  Created by Feiyou Guo on 9/14/20.
//  Copyright © 2020 Exquisitian. All rights reserved.
//

import UIKit

public class CICheckmark: CIButton {
	public init(isChecked: Bool,
		 style: CITableViewCell.Style.CICheckMark,
		 tintColor: UIColor = .systemBlue,
		 delegate: CIButtonDelegate,
		 position: CITableViewCell.ComponentPosition.CICheckMark) {
		// Initialization
		super.init(delegate: delegate, position: .Left)
		self.position = position.toCellPosition()
		self.CIViewType = .checkMark
		
		// General
		self.setImage(style.normalImage.withRenderingMode(.alwaysTemplate), for: .normal)
		self.setImage(style.selectedImage.withRenderingMode(.alwaysTemplate), for: .selected)

		// Style
		self.isSelected = isChecked
		self.tintColor = tintColor
		self.backgroundColor = .clear

		// Constraint
		NSLayoutConstraint.activate([
			self.widthAnchor.constraint(equalToConstant: 20),
			self.heightAnchor.constraint(equalToConstant: 20)
		], priority: .required)
	}
	
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
}
