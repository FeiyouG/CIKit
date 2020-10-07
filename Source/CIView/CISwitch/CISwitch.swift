//
//  CISwitch.swift
//  CITableViewCell
//
//  Created by Feiyou Guo on 9/5/20.
//  Copyright © 2020 Exquisitian. All rights reserved.
//

import UIKit

public class CISwitch: UISwitch, CIViewWrapper {
	internal var CELL_ID: CITableViewCell.ID = ""
	
	internal var position: CITableViewCell.Position = .Right
	
	internal var CIViewType: CIViewType = .SegmentedControl
	
	internal var CIViewDelegate: CIViewDelegate?
	
	internal var tableView: UITableView? 
	
	public init(delgate: CISwitchDelegate? = nil) {
		// Initialization
		self.CIViewDelegate = delgate
		super.init(frame: .zero)
		
		// General
		self.addTarget(self, action: #selector(valueChanged), for: .valueChanged)
		
		// Style
		self.backgroundColor = .clear
		
		// Constraints
		self.translatesAutoresizingMaskIntoConstraints = false
		self.setContentCompressionResistancePriority(horizontal: .medium, vertical: .medium)
		self.setContentHuggingPriority(horizontal: .high, vertical: .high)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension CISwitch {
	private var CISwtichDelegate: CISwitchDelegate? {
		return self.CIViewDelegate as? CISwitchDelegate
	}
	
	@objc func valueChanged() {
		self.CISwtichDelegate?.CISwitchValueChanged(inCellWithId: self.CELL_ID, sender: self)
	}
}
