//
//  CIStepper.swift
//  CITableViewCell
//
//  Created by Feiyou Guo on 9/5/20.
//  Copyright © 2020 Exquisitian. All rights reserved.
//

import UIKit

public class CIStepper: UIStepper, CIViewWrapper {
	internal var CELL_ID: CITableViewCell.ID = ""
	
	internal var position: CITableViewCell.Position = .Right
	
	internal var CIViewType: CIViewType = .SegmentedControl
	
	internal var CIViewDelegate: CIViewDelegate?
	
	internal var tableView: UITableView? 

	private let label: UILabel?
	
	public override var value: Double {
		didSet {
			label?.text = self.value.removeZerosFromEnd()
		}
	}
	
	/// Initialize a CIStepper.
	/// - Parameters:
	///   - delgate: the delegate of this stepper.
	///   - label: the label that will show and upate the values of the stepper.
	/// - Note:
	///		- The CIDelegate will be notified when the value of this stepper changes.
	///		- The text of the label is managed within this class. Thus there is no need and not recommanded to update the text manually somewhere else in the program. If it is done so, the behavior of the label will not be guranteed.
	public init(delgate: CIStepperDelegate? = nil, label: UILabel? = nil) {
		// Initialization
		self.CIViewDelegate = delgate
		self.label = label
		super.init(frame: .zero)
		
		// General
		self.update()
		self.addTarget(self, action: #selector(valueChanged), for: .valueChanged)
		
		// Style
		self.backgroundColor = .clear
		
		// Constraints
		self.setContentCompressionResistancePriority(horizontal: .medium, vertical: .medium)
		self.setContentHuggingPriority(horizontal: .high, vertical: .high)
	}
	
	internal func update() {
		let stepperValue = self.CISwtichDelegate.CIStepperValues(inCellWithId: self.CELL_ID)
		self.minimumValue = stepperValue.minValue
		self.maximumValue = stepperValue.maxValue
		self.stepValue = stepperValue.step
		self.value = stepperValue.defaultValue
		label?.text = stepperValue.defaultValue.removeZerosFromEnd()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension CIStepper {
	private var CISwtichDelegate: CIStepperDelegate {
		return self.CIViewDelegate as! CIStepperDelegate
	}
	
	@objc func valueChanged() {
		label?.text = self.value.removeZerosFromEnd()
		self.CISwtichDelegate.CIStepperValueChanged(inCellWithId: self.CELL_ID, sender: self)
	}
}
