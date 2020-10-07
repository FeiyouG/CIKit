//
//  CIDescriptionLabel.swift
//  ConvenientCell
//
//  Created by Feiyou Guo on 9/14/20.
//  Copyright © 2020 Exquisitian. All rights reserved.
//

import UIKit

public class CIDescriptionLabel: CILabel {
	public init(text: String) {

		// Initialization
		super.init(text: text, position: .MiddleLowerLeft)
		
		// General

		// Style
		self.numberOfLines = 0
		self.font = UIFont.systemFont(ofSize: 12, weight: .regular)

		// Constraint
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
