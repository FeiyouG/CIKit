//
//  CIStepperDelegate.swift
//  CITableViewCell
//
//  Created by Feiyou Guo on 6/18/20.
//  Copyright © 2020 Exquisitian. All rights reserved.
//

import UIKit


public protocol CIStepperDelegate: CIViewDelegate {
	func CIStepperValues(inCellWithId id: CITableViewCell.ID) -> (minValue: Double, maxValue: Double, step: Double, defaultValue: Double)
	func CIStepperValueChanged(inCellWithId id: CITableViewCell.ID, sender: UIStepper)
}
