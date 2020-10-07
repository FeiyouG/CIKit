//
//  ComponentWrapper.swift
//  CITableViewCell
//
//  Created by Feiyou Guo on 9/14/20.
//  Copyright © 2020 Exquisitian. All rights reserved.
//

import UIKit

internal protocol CIViewWrapper: CIView {
	var CELL_ID: CITableViewCell.ID { get set }
	var position: CITableViewCell.Position { get }
	var CIViewType: CIViewType { get }
	var CIViewDelegate: CIViewDelegate? { get }
	var tableView: UITableView? { get set }
}
