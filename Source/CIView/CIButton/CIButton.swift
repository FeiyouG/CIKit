//
//  CIButton.swift
//  CITableViewCell
//
//  Created by Feiyou Guo on 9/5/20.
//  Copyright © 2020 Exquisitian. All rights reserved.
//

import UIKit

public class CIButton: UIButton, CIViewWrapper {
	internal var CELL_ID: CITableViewCell.ID = ""
	
	internal var position: CITableViewCell.Position = .Left
	
	internal var CIViewType: CIViewType = .ImageView
	
	internal var CIViewDelegate: CIViewDelegate?
	
	internal var tableView: UITableView?
	
	fileprivate var CIButtonPosition: CITableViewCell.ComponentPosition.CIView {
		return CITableViewCell.ComponentPosition.CIView(from: self.position)!
	}
	
	public init(text: String? = nil,
				image: UIImage? = nil,
				delegate: CIButtonDelegate,
				position: CITableViewCell.ComponentPosition.CIView) {
		// Initialization
		self.position = position.toCellPosition()
		self.CIViewDelegate = delegate
		super.init(frame: CGRect.zero)
		
		// General
		self.setTitle(text, for: .normal)
		self.setImage(image, for: .normal)
		self.addTarget(self, action: #selector(toggleButton(sender:)), for: .touchUpInside)

		// Style

		// Constraint
		self.translatesAutoresizingMaskIntoConstraints = false
		self.setContentCompressionResistancePriority(horizontal: .medium, vertical: .medium)
		self.setContentHuggingPriority(horizontal: .medium, vertical: .medium)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	@objc private func toggleButton(sender: UIButton) {
		self.isSelected = !self.isSelected
		(self.CIViewDelegate as! CIButtonDelegate).valuChanged(inCellWithId: self.CELL_ID, at: self.CIButtonPosition, sender: self)
	}
}
