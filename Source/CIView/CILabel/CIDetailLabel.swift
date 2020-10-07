//
//  CIDetailLabel.swift
//  CITableViewCell
//
//  Created by Feiyou Guo on 9/14/20.
//  Copyright © 2020 Exquisitian. All rights reserved.
//

import UIKit

public class CIDetailLabel: CILabel {
	public init(text: String) {

		// Initialization
		super.init(text: text, position: .MiddleUpperRight)
		
		// General

		// Style
		self.numberOfLines = 1
		self.font = UIFont.systemFont(ofSize: 14, weight: .regular)

		// Constraint
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
