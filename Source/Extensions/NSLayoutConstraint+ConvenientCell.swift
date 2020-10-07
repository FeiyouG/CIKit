//
//  NSLayoutConstraint.swift
//  Test
//
//  Created by Feiyou Guo on 4/10/20.
//  Copyright © 2020 Exquisitian. All rights reserved.
//

import UIKit

internal extension NSLayoutConstraint {
	class var CISegmentedControlTextPadding: (horizontal: CGFloat, vertical: CGFloat) {
		return (horizontal: 12, vertical: 12)
	}
	
	class var CISegmentedControlSpacing: CGFloat {
		return 8
	}
}

internal extension NSLayoutConstraint {
	enum AnchorType: String {
		case top = "TOP_ANCHOR", bottom="BOTTOM_ANCHOR", leading="LEADING_ANCHOR", trailing="TRAILING_ANCHOR"
		case centerX="CENTER_X_ANCHOR", centerY="CENTER_Y_ANCHOR"
		case height="HEGITH_ANCHOR", width="WIDTH_ANCHOR"
	}
		
	/// Activate a `NSLayoutConstraint` with an identifier
	/// - Parameter identifier: the identifier of the cosntraint
	func activate(withIdentifier identifier: String) {
        self.identifier = identifier
        self.isActive = true
    }
	
	/// Activate a dictionary`NSLayoutConstraint` with `anchorType` as their identifier
	/// - Parameter constraints: a dictionary of `NSLayoutConstraint` with  `anchorType` as the keys
	static func activateWithAnchorType(_ constraints: [AnchorType: NSLayoutConstraint],
									   priority: CILayoutPriority? = nil) {
		for (anchorType, constraint) in constraints {
			if let priority = priority { constraint.priority = priority.priority }
			constraint.isActive = true
			constraint.identifier = anchorType.rawValue
		}
	}
	
	/// Activate a dictionary`NSLayoutConstraint` with `anchorType` as their identifier
	/// - Parameter constraints: a dictionary of `NSLayoutConstraint` with  `anchorType` as the keys
	static func activateWithAnchorType(_ constraints: [AnchorType: [NSLayoutConstraint]],
									   priority: CILayoutPriority? = nil) {
		for (anchorType, constraints) in constraints {
			for constraint in constraints {
				if let priority = priority { constraint.priority = priority.priority }
				constraint.isActive = true
				constraint.identifier = anchorType.rawValue
			}
		}
	}
	
	/// Activate an array of `NSLayoutCOnstraint` with each of them having priority set to `priority`
	static func activate(_ constraints: [NSLayoutConstraint], priority: CILayoutPriority) {
		constraints.forEach { $0.priority = priority.priority }
		NSLayoutConstraint.activate(constraints)
    }
	
}


