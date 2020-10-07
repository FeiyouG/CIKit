//
//  CISegmentedControl.swift
//  CITableViewCell
//
//  Created by Feiyou Guo on 9/5/20.
//  Copyright © 2020 Exquisitian. All rights reserved.
//

import UIKit

public class CISegmentedControl: UISegmentedControl, CIViewWrapper {
	internal var CELL_ID: CITableViewCell.ID = ""
	
	internal var position: CITableViewCell.Position = .Right
	
	internal var CIViewType: CIViewType = .SegmentedControl
	
	internal var CIViewDelegate: CIViewDelegate?
	
	internal var tableView: UITableView?
	
	/// Initialize a SegmentedControl
	/// - Parameter delgate: the delegate of this Segmented Control
	public init(delgate: CISegmentedControlDelegate) {
		// Initialization
		self.CIViewDelegate = delgate
		super.init(frame: .zero)
		
		// General
		self.CISegmentedControlDelegate.CISegmentedConrolTitles(inCellWithId: self.CELL_ID)
			.enumerated()
			.forEach { (i, title) in
			self.insertSegment(withTitle: title, at: i, animated: false)
		}
		self.selectedSegmentIndex = self.CISegmentedControlDelegate.CISegmntedControlSelectedIndex(inCellWithId: self.CELL_ID)
		self.addTarget(self, action: #selector(valueChanged), for: .valueChanged)
		
		// Style
		self.backgroundColor = .clear
		
		// Constraints
		self.translatesAutoresizingMaskIntoConstraints = false
		self.setContentCompressionResistancePriority(horizontal: .high, vertical: .high)
		self.setContentHuggingPriority(horizontal: .high, vertical: .high)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension CISegmentedControl {
	private var CISegmentedControlDelegate: CISegmentedControlDelegate {
		return self.CIViewDelegate as! CISegmentedControlDelegate
	}
	
	@objc func valueChanged() {
		self.CISegmentedControlDelegate.CISegmentedControlValueChange(inCellWithId: self.CELL_ID, sender: self)
	}
}
