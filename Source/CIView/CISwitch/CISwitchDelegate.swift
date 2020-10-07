//
//  CISwitchDelegate.swift
//  CITableViewCell
//
//  Created by Feiyou Guo on 6/18/20.
//  Copyright © 2020 Exquisitian. All rights reserved.
//

import UIKit

public protocol CISwitchDelegate: CIViewDelegate {
	func CISwitchValueChanged(inCellWithId id: CITableViewCell.ID, sender: UISwitch)
}
