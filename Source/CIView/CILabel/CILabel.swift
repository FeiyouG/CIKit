//
//  CITitleLabel.swift
//  CITableViewCell
//
//  Created by Feiyou Guo on 9/4/20.
//  Copyright © 2020 Exquisitian. All rights reserved.
//

import UIKit

public class CILabel: UILabel, CIViewWrapper {
	
	internal var CELL_ID: CITableViewCell.ID = ""

	internal var position: CITableViewCell.Position = .Left

	internal var CIViewType: CIViewType = .Label

	internal var CIViewDelegate: CIViewDelegate?
	
	internal var tableView: UITableView?

	public init(text: String? = nil, position: CITableViewCell.ComponentPosition.CILabel = .MiddleUpperLeft) {

		// Initialization
		self.position = position.toCellPosition()
		super.init(frame: CGRect.zero)

		// General
		self.text = text
		self.backgroundColor = .clear

		// Style
		self.numberOfLines = 0
		self.textAlignment = self.position.defaulTextAligment
		self.font = UIFont.systemFont(ofSize: 18, weight: .regular)

		// Constraint
		self.translatesAutoresizingMaskIntoConstraints = false
		self.setContentCompressionResistancePriority(horizontal: .medium, vertical: .medium)
		self.setContentHuggingPriority(horizontal: .medium, vertical: .medium)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

