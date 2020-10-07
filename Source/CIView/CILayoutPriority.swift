//
//  CILayoutPriority.swift
//  ConvenientCell
//
//  Created by Feiyou Guo on 7/18/20.
//  Copyright © 2020 Exquisitian. All rights reserved.
//

import UIKit

/// The Layout Prioirity used in Convenient Cell
internal enum CILayoutPriority: Int {
	case required = 0, high, medium, low, insignificant
	var priority: UILayoutPriority {
		return UILayoutPriority.init(rawValue: 1000 - Float(self.rawValue))
	}
}
