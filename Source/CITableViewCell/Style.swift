//
//  Spacing.swift
//  ConvenientCell
//
//  Created by Feiyou Guo on 9/4/20.
//  Copyright © 2020 Exquisitian. All rights reserved.
//

import UIKit

public extension CITableViewCell {
	struct   Style {
		var showHighlight: Bool = true
		
		var color: Color = Color()
		var size: Size = Size()
	}
	
	struct Color {
		var backgroundColorNormal: UIColor = .white
		var backgroundColorHighlighted: UIColor = .gray
	}
	
	struct Size {
		var ComponentSpacing: Spacing = Spacing(Horizontal: 18, Vertical: 16)
		var PeripheralSpacing: Spacing = Spacing(Horizontal: 12, Vertical: 12)
		
		struct Spacing {
			var Horizontal: CGFloat
			var Vertical: CGFloat
		}
	}
	
	
}

public extension CITableViewCell.Style {
	enum CIIndicator: CaseIterable {
		case More, Info, Plus
		
		private var iconCongiguration: UIImage.SymbolConfiguration {
			return UIImage.SymbolConfiguration(weight: .regular)
		}
		
		private var iconName: String {
			switch self {
			case .More: return "ellipsis"
			case .Info: return "info.circle"
			case .Plus: return "plus"
			}
		}
		
		internal var image: UIImage {
			return UIImage(systemName: self.iconName, withConfiguration: iconCongiguration)!
		}
		
		
	}
}


public extension CITableViewCell.Style {
	enum CICheckMark: CaseIterable {
		case Default, Square
		
		private var iconCongiguration: UIImage.SymbolConfiguration {
			return UIImage.SymbolConfiguration(weight: .regular)
		}
		
		internal var normalImage: UIImage {
			switch self {
			case .Default: return UIImage()
			case .Square: return UIImage(systemName: "square", withConfiguration: iconCongiguration)!
			}
		}
		
		internal var selectedImage: UIImage {
			switch self {
			case .Default: return UIImage(systemName: "checkmark", withConfiguration: iconCongiguration)!
			case .Square: return UIImage(systemName: "square.fill", withConfiguration: iconCongiguration)!
			}
		}
	}
}
