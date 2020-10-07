//
//  ViewController.swift
//  ConvenientCell
//
//  Created by Feiyou Guo on 9/4/20.
//  Copyright © 2020 Exquisitian. All rights reserved.
//

import UIKit
import CIKit

class MainViewController: UIViewController {
	
	
	let CELL_RESUABLE_ID: String = "CI_TABLEVIEW_CELL"
	let tableView = UITableView(frame: CGRect.zero, style: .insetGrouped)

	override func viewDidLoad() {
		super.viewDidLoad()
//		self.view.backgroundColor = .gray
		setupNavController()
		setupTableview()
		print("View did load")
	}

	override func viewWillAppear(_ animated: Bool) {
		tableView.estimatedRowHeight = 600
	}

	func setupNavController() {
		// General
		self.navigationItem.title = "CI Demo"
		self.navigationController?.navigationBar.prefersLargeTitles = true
		
		// Style
		self.navigationController?.navigationBar.backgroundColor = UIColor.clear
		self.navigationController?.navigationBar.largeTitleTextAttributes = [
			NSAttributedString.Key.foregroundColor: UIColor.black
		]

		tabBarController?.tabBar.isHidden = false
	}
	
	func setupTableview() {
		let superview = self.view!

		// Configurations
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.isScrollEnabled = true
		tableView.register(CITableViewCell.self, forCellReuseIdentifier: CELL_RESUABLE_ID)

//		tableView.backgroundColor = .clear
		tableView.dataSource = self
		tableView.delegate = self
		tableView.separatorStyle = .none
		tableView.delaysContentTouches = false
		tableView.showsVerticalScrollIndicator = false

		superview.addSubview(tableView)

		// Constraints
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: superview.topAnchor),
			tableView.bottomAnchor.constraint(equalTo: superview.bottomAnchor),
			tableView.leftAnchor.constraint(equalTo: superview.leftAnchor),
			tableView.rightAnchor.constraint(equalTo: superview.rightAnchor)
		])
	}
}

// MARK:- Conform to UITableView Delegate and Datasource
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return MainVCSection.allCases.count
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return MainVCSection(rawValue: section)!.rows.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let section = MainVCSection(rawValue: indexPath.section)!
		let row = section.rows[indexPath.row]
		
		let components: [CIView] = [CITitleLabel(text: row.description), CIChevronIcon()]
					
		let cell = tableView.dequeueReusableCell(withIdentifier: CELL_RESUABLE_ID) as? CITableViewCell ?? CITableViewCell()
		cell.backgroundColorSelected = .gray
		cell.setComponents(to: components)
		return cell

	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let section = MainVCSection(rawValue: indexPath.section)!
		let row = section.rows[indexPath.row]
		let demoVC = DemoTableViewController(style: .insetGrouped)
		
		
		
		var components: [[[CIView]]] = []
		switch row {
		case .Label:
			components.append(self.baseCases)
		case .TextView:
			for position in CITableViewCell.ComponentPosition.CITextView.allCases {
				components.append( self.baseCases.map {
					let textView = CITextView(delegate: demoVC, position: position)
					textView.textColor = .black
					textView.placeHolder = "THIS IS A PLACE HOLDER"
					return $0 + [textView]
				})
			}
			
		case .Chevron:
			components.append( self.baseCases.map { $0 + [CIChevronIcon()] })
		case .CheckMark:
			for style in CITableViewCell.Style.CICheckMark.allCases {
				for position in CITableViewCell.ComponentPosition.CICheckMark.allCases {
					components.append( self.baseCases.map {
						$0 + [CICheckmark(isChecked: true, style: style, delegate: demoVC, position: position)]
					})
				}
			}
		case .Indicator:
			for style in CITableViewCell.Style.CIIndicator.allCases {
				for position in CITableViewCell.ComponentPosition.CIIndicator.allCases {
					components.append( self.baseCases.map {
						$0 + [CIIndicator(style: style, delegate: demoVC, position: position)]
					})
				}
			}
		case .SegmentedControl:
			components.append( self.baseCases.map { $0 + [CISegmentedControl(delgate: demoVC)] })
		case .Switch:
			components.append( self.baseCases.map { $0 + [CISwitch(delgate: demoVC)] })
		case .Stepper:
			components.append( self.baseCases.map { $0 + [CIStepper(delgate: demoVC)] })
		}
		
		demoVC.setComponenet(components)
		demoVC.title = row.description
		self.navigationController?.pushViewController(demoVC, animated: true)
		self.tableView.deselectRow(at: indexPath, animated: true)
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableViewAutomaticDimension
	}

	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		return UIView()
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 25
	}
	
	private var baseCases: [[CIView]] {
		let title = "Title Label"
		let detail = "Detail Label"
		let description = "Description Label can be very very very very very vary very very very very very vary very very very very very vary long"
		return [
			[CITitleLabel(text: title)],
			
			[CIDetailLabel(text: detail)],
			
			[CIDescriptionLabel(text: description)],
			
			[CITitleLabel(text: title),
			 CIDetailLabel(text: detail)],
			
			[CITitleLabel(text: title),
			 CIDescriptionLabel(text: description)],
			
			[CITitleLabel(text: title),
			 CIDetailLabel(text: detail),
			 CIDescriptionLabel(text: description)],
		]
	}
}

enum MainVCSection: Int, CaseIterable {
	case Plain
	case TextView 
	case Image
	case Button
	case Others
	
	var description: String {
		switch self {
		case .Plain:	return "Plain"
		case .TextView:	return "CITextView"
		case .Image:	return "CIImage"
		case .Button:	return "CIButton"
		case .Others:	return "Others"
		}
	}

	var rows: [MainVCRow] {
		switch self {
		case .Plain: 	return [.Label]
		case .TextView: return [.TextView]
		case .Image: 	return [.Chevron]
		case .Button: 	return [.CheckMark, .Indicator]
		case .Others: 	return [.SegmentedControl, .Switch, .Stepper]
		}
	}
	
	
}

enum MainVCRow: Int {
	case Label
	case TextView
	case Chevron
	case CheckMark
	case Indicator
	case SegmentedControl
	case Switch
	case Stepper
	
	var description: String {
		switch self {
		case .Label: 		return "CILabel"
		case .TextView: 	return "CITextView"
		case .Chevron: 		return "CIChevron"
		case .CheckMark: 	return "CICheckMark"
		case .Indicator: 	return "CIIndicator"
		case .SegmentedControl: return "CISegmented Control"
		case .Switch: 		return "CISwtich"
		case .Stepper: 		return "CIStepper"
		}
	}
	
	var rows: [DemoVCSection] {
		switch self {
		case .Label: 		return [.TitleLabel, .DetailLabel, .DescriptionLabel, .MixedLabels]
		case .TextView: 	return [.TextView_MUR, .TextView_MUL, .TextView_MLR, .TextView_MLL]
		case .Chevron: 		return [.Chevron, .Chevron_Label]
		case .CheckMark: 	return [.CheckMark, .CheckMark_Label]
		case .Indicator: 	return [.Indicator, .Indicator_Label]
		case .SegmentedControl: return [.SegmentedControl, .SegmentedControl_Label]
		case .Switch: 		return [.Switch, .Switch_Label]
		case .Stepper: 		return [.Stepper, .Stepper_Label]
		}
	}
	
	var components: [CIView] {
		return [CITitleLabel(text: self.description), CIChevronIcon()]
	}
}

enum DemoVCSection: Int {
	case TitleLabel, DetailLabel, DescriptionLabel, MixedLabels
	case TextView_MUR, TextView_MUL, TextView_MLR, TextView_MLL
	case Chevron, Chevron_Label
	case CheckMark, CheckMark_Label
	case Indicator, Indicator_Label
	case SegmentedControl, SegmentedControl_Label
	case Switch, Switch_Label
	case Stepper, Stepper_Label
	
	var description: String {
		switch self {
		case .TitleLabel:		return ""
		case .DetailLabel:		return ""
		case .DescriptionLabel:	return ""
		case .MixedLabels:		return ""
		case .TextView_MUR:		return ""
		case .TextView_MUL:		return ""
		case .TextView_MLR:		return ""
		case .TextView_MLL:		return ""
		case .Chevron:			return ""
		case .Chevron_Label:	return ""
		case .CheckMark:		return ""
		case .CheckMark_Label:	return ""
		case .Indicator:		return ""
		case .Indicator_Label:	return ""
		case .SegmentedControl:	return ""
		case .SegmentedControl_Label:	return ""
		case .Switch:			return ""
		case .Switch_Label:		return ""
		case .Stepper:			return ""
		case .Stepper_Label:	return ""
		}
	}
	
//	private var titleLabelString: String { return "Title Label" }
//	private var detailLabelString: String { return "Detail Label" }
//	private var descriptionLabelString: String {
//		return "Description Label can be very very very very very vary very very very very very vary very very very very very vary long"
//	}
//
//	private func CITextView(position: ConvenientCell.ComponentPosition.CITextView) -> CITextView {
//
//	}
//
//	var components: [[CIComponent]] {
//		switch self {
//		case .TitleLabel:		return [[CITitleLabel(text: titleLabelString)]]
//		case .DetailLabel:		return [[CIDetailLabel(text: detailLabelString)]]
//		case .DescriptionLabel:	return [[CIDescriptionLabel(text: descriptionLabelString)]]
//		case .MixedLabels:
//			return [
//				[CITitleLabel(text: titleLabelString),
//				 CIDetailLabel(text: detailLabelString)],
//
//				[CITitleLabel(text: titleLabelString),
//				 CIDescriptionLabel(text: descriptionLabelString)],
//
//				[CIDetailLabel(text: detailLabelString),
//				 CIDescriptionLabel(text: descriptionLabelString)],
//
//				[CITitleLabel(text: titleLabelString),
//				 CIDetailLabel(text: detailLabelString),
//				 CIDescriptionLabel(text: descriptionLabelString)],
//			]
//		case .TextView_MUR:
//			return DemoVCSection.MixedLabels.components.map {
//				let textView = CITextView(delegate: DemoTableViewController.shared, position: .MiddleUpperRight)
//				textView.textColor = .black
//				textView.placeHolder = "THIS IS A PLACE HOLDER"
//				return $0 + [textView]
//			}
//
//		case .TextView_MUL:		return
//
//		case .TextView_MLR:		return ""
//		case .TextView_MLL:		return ""
//		case .Chevron:			return ""
//		case .Chevron_Label:	return ""
//		case .CheckMark:		return ""
//		case .CheckMark_Label:	return ""
//		case .Indicator:		return ""
//		case .Indicator_Label:	return ""
//		case .SegmentedControl:	return ""
//		case .SegmentedControl_Label:	return ""
//		case .Switch:			return ""
//		case .Switch_Label:		return ""
//		case .Stepper:			return ""
//		case .Stepper_Label:	return ""
//		}
//	}
}
