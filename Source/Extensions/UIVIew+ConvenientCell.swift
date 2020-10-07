//
//  UIVIew.swift
//  ConvenientCell
//
//  Created by Feiyou Guo on 9/4/20.
//  Copyright © 2020 Exquisitian. All rights reserved.
//

import UIKit

extension UIView {
	/// Sets the priority with which a view resists being made smaller than its intrinsic size for its horizontal and vertical aix.
	func setContentCompressionResistancePriority(horizontal: CILayoutPriority,
												 vertical: CILayoutPriority) {
		self.setContentCompressionResistancePriority(horizontal.priority, for: .horizontal)
		self.setContentCompressionResistancePriority(vertical.priority, for: .vertical)
	}
	
	/// Sets the priority with which a view resists being made larger than its intrinsic size for its horizontal and vertical aix.
	func setContentHuggingPriority(horizontal: CILayoutPriority,
								   vertical: CILayoutPriority) {
		self.setContentHuggingPriority(horizontal.priority, for: .horizontal)
		self.setContentHuggingPriority(vertical.priority, for: .vertical)
	}
	
	/// Returns the first constraint with the given identifier, if available.
    /// - Parameter identifier: The constraint identifier.
    func constraintWithIdentifier(_ identifier: String) -> NSLayoutConstraint? {
		
		if let constraint = self.constraints.first(where: { $0.identifier == identifier }) {
			return constraint
		} else if let constraint = self.superview?.constraints.first(where: { $0.identifier == identifier }) {
			return constraint
		}
		
		return nil
    }
}
