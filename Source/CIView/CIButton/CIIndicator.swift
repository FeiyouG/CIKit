//
//  CIIndicator.swift
//  CITableViewCell
//
//  Created by Feiyou Guo on 9/14/20.
//  Copyright © 2020 Exquisitian. All rights reserved.
//

import UIKit

public class CIIndicator: CIButton {
	public init(style: CITableViewCell.Style.CIIndicator,
		 tintColor: UIColor = .systemBlue,
		 delegate: CIButtonDelegate,
		 position: CITableViewCell.ComponentPosition.CICheckMark) {
		// Initialization
		super.init(delegate: delegate, position: .Left)
		self.position = position.toCellPosition()
		self.CIViewType = .checkMark
		
		// General
		self.setImage(style.image.withRenderingMode(.alwaysTemplate), for: .normal)
		
		// Style
		self.tintColor = tintColor
		self.adjustsImageWhenHighlighted = true
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
