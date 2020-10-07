//
//  CITitleLabel.swift
//  ConvenientCell
//
//  Created by Feiyou Guo on 9/14/20.
//  Copyright © 2020 Exquisitian. All rights reserved.
//

import UIKit

public class CITitleLabel: CILabel {
	public init(text: String) {

		// Initialization
		super.init(text: text, position: .MiddleUpperLeft)
		
		// General

		// Style
		self.numberOfLines = 1
		self.textAlignment = .left

		// Constraint
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
