//
//  CITextView.swift
//  CITableViewCell
//
//  Created by Feiyou Guo on 9/4/20.
//  Copyright © 2020 Exquisitian. All rights reserved.
//

import UIKit

public class CITextView: UITextView, CIViewWrapper {
	
	internal var CELL_ID: CITableViewCell.ID = ""
	
	internal var position: CITableViewCell.Position = .Left
	
	internal var CIViewType: CIViewType = .TextView
	
	internal var CIViewDelegate: CIViewDelegate?
	
	internal var tableView: UITableView?
	
	// Manage TextColor
	private var placeHolderTextColor: UIColor?
	private var normalTextColor: UIColor?
	public override var textColor: UIColor? {
		didSet {
			if oldValue != self.normalTextColor && oldValue != self.placeHolderTextColor {
				self.normalTextColor = self.textColor
				self.placeHolderTextColor = self.textColor?.adjustAutomatic(by: 0.5)
				if self.isPlaceHolderShown {
					self.textColor = self.placeHolderTextColor
				}
			}
		}
	}

	
	/// Indicating whether place holder is currebtly shown
	internal var isPlaceHolderShown: Bool = true
	
	/// Place Holder will be shown when text is empty
	/// - Note: setup placeHolder after assign textColor, or the color of the place holder will be unpredicated.
	public var placeHolder: String? = nil {
		didSet {
			if self.placeHolder == nil {
				self.hidePlaceHolder()
			} else {
				self.showPlaceHolder()
			}
		}
	}
	
	/// Return true if self is empty, regardless of placeHolder
	public var isEmpty: Bool {
		return self.text.isEmpty || self.text == self.placeHolder
	}
		
	/// The minimum number of lines the textview will display
	/// - Note: Only valid if textview.font is not nil
	private let MINI_NUM_LINE_ID = "MINI_NUM_LINE_ID"
	public var miniNumOfLine: Int? = nil {
		didSet {
			guard let minLine = self.miniNumOfLine else {
				if let constraint = self.constraintWithIdentifier(self.MINI_NUM_LINE_ID) {
					constraint.isActive = false
				}
				return
			}
			
			if let constraint = self.constraintWithIdentifier(self.MINI_NUM_LINE_ID) {
				constraint.constant = CGFloat(minLine)
			} else {
				self.heightAnchor.constraint(greaterThanOrEqualToConstant: (self.font ?? UIFont.systemFont(ofSize: 14, weight: .regular)).lineHeight * CGFloat(minLine))
					.activate(withIdentifier: self.MINI_NUM_LINE_ID)
			}
		}
	}
	
	/// The maximum number of lines the textview will display
	/// - Note: Only valid if textview.font is not nil
	private let MAX_NUM_LINE_ID = "MAX_NUM_LINE_ID"
	public var maxNumOfLine: Int? = nil {
		didSet {
			guard let maxLine = self.maxNumOfLine else {
				if let constraint = self.constraintWithIdentifier(self.MAX_NUM_LINE_ID) {
					constraint.isActive = false
				}
				return
			}
			
			if let constraint = self.constraintWithIdentifier(self.MAX_NUM_LINE_ID) {
				constraint.constant = CGFloat(maxLine)
			} else {
				self.heightAnchor.constraint(lessThanOrEqualToConstant: (self.font ?? UIFont.systemFont(ofSize: 14, weight: .regular)).lineHeight * CGFloat(maxLine))
					.activate(withIdentifier: self.MINI_NUM_LINE_ID)

			}
		}
	}
	
	public init(defaultText: String? = nil,
				delegate: CITextViewDelegate,
				position: CITableViewCell.ComponentPosition.CITextView) {
		
		// Initialization
		self.CIViewDelegate = delegate
		self.position = position.toCellPosition()
		
		super.init(frame: CGRect.zero, textContainer: nil)
		
		// General
		self.isEditable = true
		self.isScrollEnabled = false
		self.isUserInteractionEnabled = true
		self.delegate = self

		// Style
//		self.backgroundColor = .green
		self.contentInset = UIEdgeInsets.zero
		self.textContainerInset = .zero
		self.textContainer.lineFragmentPadding = 0
		self.font = UIFont.systemFont(ofSize: 14, weight: .regular)
		self.backgroundColor = .clear
		
		if let defaultText = defaultText {
			self.text = defaultText
			self.isPlaceHolderShown = false
		}

		self.textAlignment = self.position.defaulTextAligment
		
		// Constraint
		self.translatesAutoresizingMaskIntoConstraints = false
		self.setContentCompressionResistancePriority(horizontal: .medium, vertical: .medium)
		self.setContentHuggingPriority(horizontal: .medium, vertical: .medium)
		
		// Set max and min number of lines
//		self.heightAnchor.constraint(greaterThanOrEqualToConstant: font.)
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

// MARK:- Conform to UITextViewDelegate
extension CITextView: UITextViewDelegate {
	
	// Privare Helper Variables and Methods
	private var CITextViewDelegate: CITextViewDelegate {
		return self.CIViewDelegate as! CITextViewDelegate
	}
	
	fileprivate var CITextViewPosition: CITableViewCell.ComponentPosition.CITextView {
		return CITableViewCell.ComponentPosition.CITextView(from: self.position) ?? .MiddleUpperRight
	}
	
	private func updateSuperViewIfIsTableView() {
		// Superview is cell.content; superview.superview is UITableviewCell;
		// superview.superview.superview is ?; superview.superview.superview.superview is UITableView
		weak var tableView = self.tableView
//		weak var tableView = (self.superview as? UITableViewCell)?.superview as? UITableView
		tableView?.beginUpdates()
		tableView?.endUpdates()
	}
	
	// UITextViewDelegate
	public func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
		return self.CITextViewDelegate.CITextViewShouldEndEditing(inCellWithId: CELL_ID, at: self.CITextViewPosition, textView: self)
	}
	
	public func textViewDidBeginEditing(_ textView: UITextView) {
		self.hidePlaceHolder()
		self.CITextViewDelegate.CITextViewDidBeginEditing(inCellWithId: CELL_ID, at: self.CITextViewPosition, textView: self)
	}
	
	// Response to end editing
	public func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
		return self.CITextViewDelegate.CITextViewShouldEndEditing(inCellWithId: CELL_ID, at: self.CITextViewPosition, textView: self)
	}
	
	public func textViewDidEndEditing(_ textView: UITextView) {
		self.showPlaceHolder()
		self.CITextViewDelegate.CITextViewDidEndEditing(inCellWithId: CELL_ID, at: self.CITextViewPosition, textView: self)
		
	}
	
	// Response to change
	public func textViewDidChange(_ textView: UITextView) {
		self.CITextViewDelegate.CITextViewDidChange(inCellWithId: CELL_ID, at: self.CITextViewPosition, textView: self)
		self.updateSuperViewIfIsTableView()
	}
	
	public func textViewDidChangeSelection(_ textView: UITextView) {
		self.CITextViewDelegate.CITextViewDidChangeSelection(inCellWithId: CELL_ID, at: self.CITextViewPosition, textView: self)
	}
	
	
	public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
		return self.CITextViewDelegate.CITextView(inCellWithId: CELL_ID, at: self.CITextViewPosition, textView: self, shouldChangeTextIn: range, replacementText: text)
	}
	
	public func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
		return self.CITextViewDelegate.CITextView(inCellWithId: CELL_ID, at: self.CITextViewPosition, textView: self, shouldInteractWith: URL, in: characterRange, interaction: interaction)
	
	}
	
	
	public func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
		return self.CITextViewDelegate.CITextView(inCellWithId: CELL_ID, at: self.CITextViewPosition, textView: self, shouldInteractWith: textAttachment, in: characterRange, interaction: interaction)
	}
}

// Private Helper Methods
extension CITextView {
	private func showPlaceHolder() {
		guard let placeHolder = self.placeHolder,
			self.text.isEmpty else { return }
		
		self.text = placeHolder
		self.textColor = self.placeHolderTextColor
		self.isPlaceHolderShown = true
	}
	
	private func hidePlaceHolder() {
		guard self.isPlaceHolderShown else { return }
		self.text = ""
		self.textColor = self.normalTextColor
		self.isPlaceHolderShown = false
	}
	
}
