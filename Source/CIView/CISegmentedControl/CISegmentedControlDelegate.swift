//
//  CISegementedControlDelegate.swift
//  CITableViewCell
//
//  Created by Feiyou Guo on 6/18/20.
//  Copyright © 2020 Exquisitian. All rights reserved.
//

import UIKit

public protocol CISegmentedControlDelegate: CIViewDelegate {
	func CISegmntedControlSelectedIndex(inCellWithId id: CITableViewCell.ID) -> Int
	func CISegmentedConrolTitles(inCellWithId id: CITableViewCell.ID) -> [String]
	func CISegmentedControlValueChange(inCellWithId id: CITableViewCell.ID, sender: UISegmentedControl)
	
	/// - Note: Default font will be overridden
	func CISegmentedControlTitleAttributes(inCellWithId id: CITableViewCell.ID, forState state: UIControl.State) -> [NSAttributedString.Key: Any]?
}
