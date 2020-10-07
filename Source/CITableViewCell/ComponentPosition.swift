//
//  ComponentPosition'.swift
//  ConvenientCell
//
//  Created by Feiyou Guo on 9/14/20.
//  Copyright © 2020 Exquisitian. All rights reserved.
//

import Foundation

public extension CITableViewCell {
	
	enum ComponentPosition {
		
		public typealias CIIndicator = CICheckMark
		
		public enum CICheckMark: ComponentPositionProtocol, CaseIterable {
			case Left, Right
			
			init?(from position: CITableViewCell.Position) {
				switch position {
				case .Left: 	self = .Left
				case .Right: 	self = .Right
				default: return nil
				}
			}
			
			internal func toCellPosition() -> CITableViewCell.Position {
				switch self {
				case .Left: 	return .Left
				case .Right: 	return .Right
				}
			}
		}
		
		
		public typealias CILabel = CIView
		public typealias CIImageView = CIView
		
		public enum CIView: ComponentPositionProtocol, CaseIterable {
			case Left, Right
			case MiddleUpperLeft, MiddleUpperRight, MiddleLowerLeft, MiddleLowerRight
			
			init?(from position: CITableViewCell.Position) {
				switch position {
				case .Left: 			self = .Left
				case .MiddleUpperLeft: 	self = .MiddleUpperLeft
				case .MiddleUpperRight: self = .MiddleUpperRight
				case .MiddleLowerLeft: 	self = .MiddleLowerLeft
				case .MiddleLowerRight: self = .MiddleLowerRight
				case .Right: 			self = .Right
				}
			}
			
			internal func toCellPosition() -> CITableViewCell.Position {
				switch self {
				case .Left: 			return .Left
				case .MiddleUpperLeft: 	return .MiddleUpperLeft
				case .MiddleUpperRight: return .MiddleUpperRight
				case .MiddleLowerLeft: 	return .MiddleLowerLeft
				case .MiddleLowerRight: return .MiddleLowerRight
				case .Right: 			return .Right
				}
			}
		}
		
		public enum CITextView: ComponentPositionProtocol, CaseIterable {
			case MiddleUpperLeft, MiddleUpperRight, MiddleLowerLeft, MiddleLowerRight
			
			init?(from position: CITableViewCell.Position) {
				switch position {
				case .MiddleUpperLeft: 	self = .MiddleUpperLeft
				case .MiddleUpperRight:	self = .MiddleUpperRight
				case .MiddleLowerLeft: 	self = .MiddleLowerLeft
				case .MiddleLowerRight: self = .MiddleLowerRight
				default: return nil
				}
			}
			
			internal func toCellPosition() -> CITableViewCell.Position {
				switch self {
				case .MiddleUpperLeft: 	return .MiddleUpperLeft
				case .MiddleUpperRight:	return .MiddleUpperRight
				case .MiddleLowerLeft: 	return .MiddleLowerLeft
				case .MiddleLowerRight: return .MiddleLowerRight
				}
			}
		}
		
	}
}
