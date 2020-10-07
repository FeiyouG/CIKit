//
//  Position.swift
//  ConvenientCell
//
//  Created by Feiyou Guo on 9/4/20.
//  Copyright © 2020 Exquisitian. All rights reserved.
//

import UIKit

internal protocol ComponentPositionProtocol {
	init?(from position: CITableViewCell.Position)
	func toCellPosition() -> CITableViewCell.Position
}

// MARK:- ConvenientCell.Position
public extension CITableViewCell {
	/// All avaliable positions in Convenient Cell
	enum Position: Int, CaseIterable {
		case Left = 0
		
		case MiddleUpperLeft
		case MiddleUpperRight
		case MiddleLowerLeft
		case MiddleLowerRight
		
		case Right
		
		internal var defaulTextAligment: NSTextAlignment {
			switch self {
			case .Left, .MiddleUpperLeft, .MiddleLowerLeft: return .left
			case .Right, .MiddleUpperRight, .MiddleLowerRight: return .right
			}
		}
	}
	
	
}



