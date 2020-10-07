//
//  UIColor+ConvenientCell.swift
//  Ahead
//
//  Created by Feiyou Guo on 3/28/20.
//  Copyright © 2020 Exquisitian. All rights reserved.
//

import UIKit

extension UIColor {
	
	/// Generate a random Color
	static var random: UIColor {
		return UIColor(red: .random(in: 0...1),
					   green: .random(in: 0...1),
					   blue: .random(in: 0...1),
					   alpha: 1.0)
	}

	
	/// DescriptionCheck if the color is light or dark, as defined by the injected lightness threshold;
	/// A nil value is returned if the lightness couldn't be determined.
	/// - Returns: True if the UIColor is dark, False other wise, and nil if undetermined.
	func isLight() -> Bool? {
		let threshold: CGFloat = 0.5
		var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0, white: CGFloat = 0
		
		if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
			return 0.299*red + 0.587*green + 0.114*blue > threshold
		} else if self.getWhite(&white, alpha: &alpha){
			return white > threshold
		}
		
		return nil
	}
	
	
	/**
		Adjust a given UIColor to a lighter or darker version by a given percentage
		- Precondition: `Percentage` must between -1 and 1
		- Parameter percentage: a given percentage that is used to adjust the UIColor
		- Returns: a darker version of the UIColor if `percentage` < 0,
					a lighter version if `percentage' > 0,
					the original color if `percentage` = 0
	*/
	func adjust(by percentage: CGFloat) -> UIColor? {
		var newPercentage: CGFloat {
			if percentage < -1 { return -1 }
			else if percentage > 1 { return 1 }
			return percentage
		}
		
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: min(red + newPercentage, 1.0),
                           green: min(green + newPercentage, 1.0),
                           blue: min(blue + newPercentage, 1.0),
                           alpha: alpha)
        } else {
            return nil
        }
    }
	
	/**
		Adjust a given UIColor to a lighter or darker version by a given percentage automatically according to its current color
		- Precondition: `Percentage` must between 0 and 1
		- Parameter percentage: a given percentage that is used to adjust the UIColor
		- Returns: a darker version of the UIColor if currentColor is light < 0,
					a lighter version if currentColor is dark > 0,
					the original color if `percentage` = 0
	*/
	func adjustAutomatic(by percentage: CGFloat) -> UIColor? {
		var newPercentage: CGFloat {
			if percentage < 0 { return 0 }
			else if percentage > 1 { return 1 }
			return percentage
		}
		
		if let isLight = isLight() {
			if isLight{
				return self.adjust(by: -newPercentage)
			} else{
				return self.adjust(by: newPercentage)
			}
		}
		
		return nil
		
	}
}
