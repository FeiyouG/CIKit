//
//  CIImageVIew.swift
//  CITableViewCell
//
//  Created by Feiyou Guo on 9/4/20.
//  Copyright © 2020 Exquisitian. All rights reserved.
//

import UIKit

public class CIImageView: UIImageView, CIViewWrapper {
	internal var CELL_ID: CITableViewCell.ID = ""
	
	internal var position: CITableViewCell.Position = .Left
	
	internal var CIViewType: CIViewType = .ImageView
	
	internal var CIViewDelegate: CIViewDelegate? 
	
	internal var tableView: UITableView?
	
	public init(image: UIImage? = nil, position: CITableViewCell.ComponentPosition.CIImageView) {
		// Initialization
		self.position = position.toCellPosition()
		super.init(frame: CGRect.zero)
		
		// General
		self.image = image

		// Style
		

		// Constraint
		self.translatesAutoresizingMaskIntoConstraints = false
		self.setContentCompressionResistancePriority(horizontal: .medium, vertical: .medium)
		self.setContentHuggingPriority(horizontal: .medium, vertical: .medium)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
