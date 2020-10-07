//
//  CITableViewCell.swift
//  CITableViewCell
//
//  Created by Feiyou Guo on 9/4/20.
//  Copyright © 2020 Exquisitian. All rights reserved.
//
// NOT SUITABLE FOR REUSING
import UIKit

public class CITableViewCell: UITableViewCell {
	
	/// The ID of this cell
	public var CELL_ID: ID = "" {
		didSet {
			self.positionMap.values.forEach { $0.CELL_ID = self.CELL_ID }
		}
	}
	
	/// The Style of this cell
	public var CELL_STYLE: Style = CITableViewCell.Style()
	
	/// The selected backgroundColor of the cell
	public var backgroundColorSelected: UIColor? = nil {
		didSet {
			self.selectedBackgroundView?.backgroundColor = self.backgroundColorSelected
		}
	}
	
	/// The minimum Height of the cell
	public var minimumHeight: CGFloat = 32
	
	/// Maps every position in the cell to the corresponding component
	private var positionMap: [CITableViewCell.Position : CIViewWrapper] = [:]
	
	/// The tableView in which this cell is located
	private var tableView: UITableView? = nil {
		didSet {
			self.positionMap.values.forEach { $0.tableView = tableView }
		}
	}
		
	// MARK:- Initializers and overwrites
	public override func awakeFromNib() {
		super.awakeFromNib()
	}

	public override required init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.setupBackground()
	}

	public required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	/// When superview changed, find the tableview and update each component's tableview
	public override func didMoveToSuperview() {
		// Two times should be sufficient
		// -> self.superView is tablview if UITableView is used
		// -> self.superView.superView is tableview if UITableViewController is used
		let maxLayer = 3
		var viewFinder: UIView? = self
		for _ in 0..<maxLayer {
			viewFinder = viewFinder?.superview
			if let tableView = viewFinder as? UITableView {
				self.tableView = tableView
				return
			}
		}
	}
	
}

extension CITableViewCell {
	public func getComponenet(at position: CITableViewCell.Position) -> UIView? {
		return self.positionMap[position]
	}
}

// MARK:- Update Components
extension CITableViewCell {
	
	/// Set the current components in this cell to components.
	/// - Parameter components: the new components that this cell is gonna contain.
	public func setComponents(to components: [CIView]) {
		
		// 1. Remove old compoenents from contentView and positionMap
		self.positionMap.values.forEach { $0.removeFromSuperview() }
		self.positionMap = [:]
		
		// 2. Update PositionMap first so that no duplicate views in one position
		components.forEach {
			let componentWrapper = self.convert($0)
			self.positionMap[componentWrapper.position] = componentWrapper
		}
		
		// 3. Add new components to contentView
		self.positionMap.values.forEach { self.contentView.addSubview($0) }
		
		// 4. Update Constraints and Style
		self.updateComponentConstraints()
	}
	
	/// Insert a component into this cell
	/// - Parameter component: the component to be inserted.
	/// - Note: If there is a component in the same position, the old component will be overwritten
	public func insertComponent(_ component: CIView) {
		
		// 1. Convert it to compoenentWrapper
		let componentWrapper = self.convert(component)
		
		// 2. Remove the view in the same position from contentView and update positionMap 
		self.positionMap[componentWrapper.position]?.removeFromSuperview()
		self.positionMap[componentWrapper.position] = componentWrapper
		
		// 3. Add new component to contentView
		self.contentView.addSubview(componentWrapper)
		
		// 4. Update Constraints
		self.updateComponentConstraints()
	}
	
	/// Remove the compoenent at position.
	/// - Parameter position: the compoenent at position will be removed from this cell.
	public func removeComponent(at position: CITableViewCell.Position) {
		
		self.positionMap[position]?.removeFromSuperview()
		self.positionMap.removeValue(forKey: position)
		
		self.updateComponentConstraints()
	}
	
	/// Get the component at position; returns nil if there isn't one.
	public func getComponent(at position: CITableViewCell.Position) -> UIView? {
		return self.positionMap[position]
	}
}

// MARK:- Update Constraints
extension CITableViewCell {
	private func updateComponentConstraints() {
		NSLayoutConstraint.activate([
			self.contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: self.CELL_STYLE.size.PeripheralSpacing.Horizontal * 2 + self.minimumHeight)
		], priority: .insignificant)
		
		positionMap.keys.forEach { self.updateConstraint(at: $0) }
	}
	
	/// Set up the constraint of a single position in this cell
	/// - Parameter position: the constraint of the position to be set
	private func updateConstraint(at position: CITableViewCell.Position)  {
		
		guard let view: UIView = positionMap[position] else { return }
				
		// All anchors are constrainted to content by default.
		var constraints: [NSLayoutConstraint.AnchorType: [NSLayoutConstraint]] = [
			.top: 		[view.topAnchor.constraint(greaterThanOrEqualTo: self.contentView.topAnchor,
													 constant: self.CELL_STYLE.size.PeripheralSpacing.Vertical)],
			.bottom: 	[view.bottomAnchor.constraint(lessThanOrEqualTo: self.contentView.bottomAnchor,
													   constant: -self.CELL_STYLE.size.PeripheralSpacing.Vertical)],
			.leading: 	[view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,
														constant: self.CELL_STYLE.size.PeripheralSpacing.Horizontal)],
			.trailing: 	[view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,
														  constant: -self.CELL_STYLE.size.PeripheralSpacing.Horizontal)],
			.centerY: 	[view.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)]
		]
		
        switch position {
        case .Left:
            // Top, Bottom, Leading -> Constraint to contentView.
			constraints[.trailing] = [view.trailingAnchor.constraint(lessThanOrEqualTo: self.contentView.trailingAnchor, constant: -self.CELL_STYLE.size.PeripheralSpacing.Horizontal)]
            // Trailing
            if let _ = positionMap[.MiddleUpperLeft] ?? positionMap[.MiddleUpperRight] ?? positionMap[.MiddleLowerLeft] ?? positionMap[.MiddleLowerRight] ?? positionMap[.Left] {
                constraints.removeValue(forKey: .trailing)
            } // Otherwise, it should constriant to contentView

        case .MiddleUpperLeft:
            // Top -> Constraint to contentView

            // Bottom
            if let _ = positionMap[.MiddleLowerLeft] ?? positionMap[.MiddleLowerRight] {
                constraints.removeValue(forKey: .bottom)
				constraints.removeValue(forKey: .centerY)
            } // Otherwise, it should constriant to contentView

            // Leading
            if let leadingView = positionMap[.Left] {
				constraints[.leading] =
					[view.leadingAnchor.constraint(equalTo: leadingView.trailingAnchor, constant: self.CELL_STYLE.size.ComponentSpacing.Horizontal)]
            } // Otherwise, constraint to contentView

            //  Trailing
            if let _ = positionMap[.MiddleUpperRight] ?? positionMap[.Right] {
                constraints.removeValue(forKey: .trailing)
            } // Otherwise, it should be set up by MLL or MLR.

        case .MiddleUpperRight:
            // Top -> Constriant to contentView

            // Bottom
            if let _ = positionMap[.MiddleLowerLeft] ?? positionMap[.MiddleLowerRight] {
                constraints.removeValue(forKey: .bottom)
				constraints.removeValue(forKey: .centerY)
            } // Otherwise, it should constriant to contentView

            // Leading
            if let leadingView = positionMap[.MiddleUpperLeft] ?? positionMap[.Left] {
				constraints[.leading] =
					[view.leadingAnchor.constraint(equalTo: leadingView.trailingAnchor, constant: self.CELL_STYLE.size.ComponentSpacing.Horizontal)]
            }
            //  Trailing
            if let _ = positionMap[.Right] {
                constraints.removeValue(forKey: .trailing)
            } // Otherwise, it should constriant to contentView

        case .MiddleLowerLeft:
            // Top
            if let topView = positionMap[.MiddleUpperLeft] ?? positionMap[.MiddleUpperRight] {
				constraints[.top] =
					[view.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: self.CELL_STYLE.size.ComponentSpacing.Vertical)]
				constraints.removeValue(forKey: .centerY)
            } // Otherwise, it should constriant to contentView

            // Bottom -> Constriant to contentView

            // Leading
            if let topView = positionMap[.MiddleUpperLeft] ?? positionMap[.MiddleUpperRight] {
				constraints[.leading] =
					[view.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 0)]
            } else if let leftView = positionMap[.Left] {
				constraints[.leading] =
					[view.leadingAnchor.constraint(equalTo: leftView.trailingAnchor, constant: self.CELL_STYLE.size.ComponentSpacing.Horizontal)]
            } // Otherwise, it should constriant to contentView

            //  Trailing
            if let _ = positionMap[.MiddleLowerRight] ?? positionMap[.Right] {
                constraints.removeValue(forKey: .trailing)
            } // Otherwise, it should constriant to contentView

        case .MiddleLowerRight:
            // Top
            if let leadingView = positionMap[.MiddleLowerLeft] {
				constraints[.top] =
					[view.topAnchor.constraint(equalTo: leadingView.topAnchor, constant: 0)]
            } else if let topView: UIView = positionMap[.MiddleUpperLeft] ?? positionMap[.MiddleUpperRight] {
				constraints[.top] =
					[view.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: self.CELL_STYLE.size.ComponentSpacing.Vertical)]
				constraints.removeValue(forKey: .centerY)
            } // Otherwise, it should constriant to contentView

            // Bottom -> Constriant to contentView

            // Leading
            if let leadingView = positionMap[.MiddleLowerLeft] {
				constraints[.leading] =
					[view.leadingAnchor.constraint(equalTo: leadingView.trailingAnchor, constant: self.CELL_STYLE.size.ComponentSpacing.Horizontal)]
            } else if let topView = positionMap[.MiddleUpperLeft] ?? positionMap[.MiddleUpperRight] {
				constraints[.leading] =
					[view.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 0)]
            } else if let leadingView = positionMap[.Left] {
				constraints[.leading] =
					[view.leadingAnchor.constraint(equalTo: leadingView.trailingAnchor, constant: self.CELL_STYLE.size.ComponentSpacing.Horizontal)]
            } // Otherwise, it should constriant to contentView

            //  Trailing
            if let _ = positionMap[.Right] {
                constraints.removeValue(forKey: .trailing)
            } // Otherwise, it should constriant to contentView

        case .Right:
            // Top, Bottom, Trailing -> Constriant to contentView.
			constraints[.leading] = [view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,
														   constant: self.CELL_STYLE.size.PeripheralSpacing.Vertical)]
			
            // Leading
			var leadingConstraints: [NSLayoutConstraint] = []
			
			if let leadingTopView = positionMap[.MiddleUpperRight] ?? positionMap[.MiddleUpperLeft] {
				leadingConstraints.append(view.leadingAnchor.constraint(equalTo: leadingTopView.trailingAnchor, constant: self.CELL_STYLE.size.ComponentSpacing.Horizontal))
			}
			
			if let leadingBottomView = positionMap[.MiddleLowerRight] ?? positionMap[.MiddleLowerLeft] ?? positionMap[.Left] {
				leadingConstraints.append(view.leadingAnchor.constraint(equalTo: leadingBottomView.trailingAnchor, constant: self.CELL_STYLE.size.ComponentSpacing.Horizontal))
			}
			
			if !leadingConstraints.isEmpty {
				constraints[.leading] = leadingConstraints
			} // Otherwise, it should constriant to contentView
        }
		
		NSLayoutConstraint.activateWithAnchorType(constraints, priority: .high)
		
		NSLayoutConstraint.activateWithAnchorType([
			.width: view.widthAnchor.constraint(lessThanOrEqualTo: self.contentView.widthAnchor, multiplier: 0.4),
		], priority: .medium)
	}
	
}

// MARK:- Update Style
extension CITableViewCell {
	
	private func setupBackground() {
		// Setup for cell background (clear background upon selection)
		let bgColorView = UIView()
		bgColorView.backgroundColor = UIColor.clear
		self.selectedBackgroundView = bgColorView
	}

}


// MARK:- Private Helper Methods
extension CITableViewCell {
	/// Convert CIComponent to ComponentWrapper, and assign CELL_ID and tableview.
	/// - Note: this conversion is upposed to success every time. Otherwise, fataError is thrown.
	private func convert(_ component: CIView) -> CIViewWrapper {
		guard let componentWrapper = component as? CIViewWrapper else {
			fatalError("Unknown Component")
		}
		
		componentWrapper.CELL_ID = self.CELL_ID
		componentWrapper.tableView = self.tableView
		return componentWrapper
	}
}
