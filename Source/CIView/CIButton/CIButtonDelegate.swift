//
//  CIButtonDelegate.swift
//  CITableViewCell
//
//  Created by Feiyou Guo on 9/5/20.
//  Copyright © 2020 Exquisitian. All rights reserved.
//

import UIKit

public protocol CIButtonDelegate: CIViewDelegate {
	func valuChanged(inCellWithId id: CITableViewCell.ID, at position: CITableViewCell.ComponentPosition.CIView,sender: UIButton)
}
