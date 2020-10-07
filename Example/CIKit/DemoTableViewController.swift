//
//  DemoViewController.swift
//  ConvenientCell
//
//  Created by Feiyou Guo on 6/30/20.
//  Copyright © 2020 Exquisitian. All rights reserved.
//

import UIKit
import CIKit

internal class DemoTableViewController: UITableViewController {
	
	static let shared: DemoTableViewController = DemoTableViewController(style: .grouped)

	private var components: [[[CIView]]] = []
	
	override init(style: UITableView.Style) {
		super.init(style: .insetGrouped)
//		self.tableView.register(ConvenientCell.self, forCellReuseIdentifier: CELL_REUSABLE_ID)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setComponenets(baseCases: [CIView], variances: [CIView]) {
		let baseCasePowerSet: [[CIView]] = baseCases.powerset.sorted(by: { $0.count < $1.count })
		
		if variances.isEmpty {
			components.append(baseCasePowerSet)
		} else {
			for variance in variances {
				let newSection: [[CIView]] = baseCasePowerSet.map { $0 + [variance] }
				components.append(newSection)
			}
		}
	}
	
	func setComponenet(_ components: [[[CIView]]]) {
		self.components = components
	}
}

extension DemoTableViewController {
	override func numberOfSections(in tableView: UITableView) -> Int {
		return self.components.count
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.components[section].count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cellComponenets = self.components[indexPath.section][indexPath.row]
		let cell = CITableViewCell()
		cell.setComponents(to: cellComponenets)
		cell.CELL_ID = indexPath
		return cell
	}
}

extension DemoTableViewController: CISegmentedControlDelegate {
	func CISegmntedControlSelectedIndex(inCellWithId id: CITableViewCell.ID) -> Int {
		return 0
	}

	func CISegmentedConrolTitles(inCellWithId id: CITableViewCell.ID) -> [String] {
		return ["1st", "2nd", "3rd"]
	}

	func CISegmentedControlValueChange(inCellWithId id: CITableViewCell.ID, sender: UISegmentedControl) {
		print(id, ": SegmentedControl",sender.selectedSegmentIndex, "is selected")
	}

	func CISegmentedControlTitleAttributes(inCellWithId id: CITableViewCell.ID, forState state: UIControl.State) -> [NSAttributedString.Key : Any]? {
		return nil
	}



}

// MARK:- CISwitchDelegate
extension DemoTableViewController: CISwitchDelegate {
	func CISwitchValueChanged(inCellWithId id: CITableViewCell.ID, sender: UISwitch) {
		print("Cell", id as! IndexPath, ": Switch is ", sender.isOn ? "On" : "Off")
	}
}

// MARK:- CITextViewDelegate
extension DemoTableViewController: CITextViewDelegate {

}

// MARK:- CIStepperDelegate
extension DemoTableViewController: CIStepperDelegate {
	func CIStepperValues(inCellWithId id: CITableViewCell.ID) -> (minValue: Double, maxValue: Double, step: Double, defaultValue: Double) {
		return (minValue: 0, maxValue: 5, step: 1, defaultValue: 0)
	}
	
	func CIStepperValueChanged(inCellWithId id: CITableViewCell.ID, sender: UIStepper) {
		print("Cell", id as! IndexPath, ": Stepper value is", sender.value)
	}
}

// MARK:- CIButtonDelegate
extension DemoTableViewController: CIButtonDelegate {
	func valuChanged(inCellWithId id: CITableViewCell.ID, at position: CITableViewCell.ComponentPosition.CIView, sender: UIButton) {
		print("Cell", id as! IndexPath, ": Button is", sender.isSelected ? "Selected" : "Unselected")
	}
	
	
}
