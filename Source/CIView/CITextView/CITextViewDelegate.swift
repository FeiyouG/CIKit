//
//  CITableViewCellDelegate.swift
//  Ahead
//
//  Created by Feiyou Guo on 3/29/20.
//  Copyright © 2020 Exquisitian. All rights reserved.
//

import UIKit

public protocol CITextViewDelegate: CIViewDelegate {
	
	func CITextViewShouldBeginEditing(inCellWithId id: CITableViewCell.ID,
									  at position: CITableViewCell.ComponentPosition.CITextView, textView: CITextView) -> Bool
	
	func CITextViewDidBeginEditing(inCellWithId id: CITableViewCell.ID,
								   at position: CITableViewCell.ComponentPosition.CITextView, textView: CITextView)
	// Response to end editing
	func CITextViewShouldEndEditing(inCellWithId id: CITableViewCell.ID,
									at position: CITableViewCell.ComponentPosition.CITextView, textView: CITextView) -> Bool
	
	func CITextViewDidEndEditing(inCellWithId id: CITableViewCell.ID,
								 at position: CITableViewCell.ComponentPosition.CITextView, textView: CITextView)
	
	// Response to change
	func CITextViewDidChange(inCellWithId id: CITableViewCell.ID,
							 at position: CITableViewCell.ComponentPosition.CITextView, textView: CITextView)
	
	func CITextViewDidChangeSelection(inCellWithId id: CITableViewCell.ID,
									  at position: CITableViewCell.ComponentPosition.CITextView, textView: CITextView)
	

	// Repsonse to interaction
	func CITextView(inCellWithId id: CITableViewCell.ID,
					at position: CITableViewCell.ComponentPosition.CITextView, textView: CITextView,
				  shouldChangeTextIn range: NSRange,
				  replacementText text: String) -> Bool
	
	func CITextView(inCellWithId id: CITableViewCell.ID,
					at position: CITableViewCell.ComponentPosition.CITextView, textView: CITextView,
				  shouldInteractWith URL: URL,
				  in characterRange: NSRange,
				  interaction: UITextItemInteraction) -> Bool
	
	func CITextView(inCellWithId id: CITableViewCell.ID,
					at position: CITableViewCell.ComponentPosition.CITextView, textView: CITextView,
				  shouldInteractWith textAttachment: NSTextAttachment,
				  in characterRange: NSRange,
				  interaction: UITextItemInteraction) -> Bool
}

public extension CITextViewDelegate {
	// Response to begin editiing
	func CITextViewShouldBeginEditing(inCellWithId id: CITableViewCell.ID,
									  at position: CITableViewCell.ComponentPosition.CITextView, textView: CITextView) -> Bool {
		return true
	}
	
	func CITextViewDidBeginEditing(inCellWithId id: CITableViewCell.ID,
								   at position: CITableViewCell.ComponentPosition.CITextView, textView: CITextView) {
	}
	
	// Response to end editing
	func CITextViewShouldEndEditing(inCellWithId id: CITableViewCell.ID,
									at position: CITableViewCell.ComponentPosition.CITextView, textView: CITextView) -> Bool {
		return true
	}
	
	func CITextViewDidEndEditing(inCellWithId id: CITableViewCell.ID,
								 at position: CITableViewCell.ComponentPosition.CITextView, textView: CITextView) {
	}
	
	// Response to change
	func CITextViewDidChange(inCellWithId id: CITableViewCell.ID,
							 at position: CITableViewCell.ComponentPosition.CITextView, textView: CITextView) {
	}
	
	func CITextViewDidChangeSelection(inCellWithId id: CITableViewCell.ID,
									  at position: CITableViewCell.ComponentPosition.CITextView, textView: CITextView) {
		
	}
	

	// Repsonse to interaction
	func CITextView(inCellWithId id: CITableViewCell.ID,
					at position: CITableViewCell.ComponentPosition.CITextView, textView: CITextView,
				  shouldChangeTextIn range: NSRange,
				  replacementText text: String) -> Bool {
		return true
	}
	
	func CITextView(inCellWithId id: CITableViewCell.ID,
					at position: CITableViewCell.ComponentPosition.CITextView, textView: CITextView,
				  shouldInteractWith URL: URL,
				  in characterRange: NSRange,
				  interaction: UITextItemInteraction) -> Bool {
		return true
	}
	
	func CITextView(inCellWithId id: CITableViewCell.ID,
					at position: CITableViewCell.ComponentPosition.CITextView, textView: CITextView,
				  shouldInteractWith textAttachment: NSTextAttachment,
				  in characterRange: NSRange,
				  interaction: UITextItemInteraction) -> Bool {
		return true
	}
	
	
}

