//
//  Double+ConvenientCell.swift
//  ConvenientCell
//
//  Created by Feiyou Guo on 9/5/20.
//  Copyright © 2020 Exquisitian. All rights reserved.
//

import Foundation

extension Double {
	func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 16 //maximum digits in Double after dot (maximum precision)
        return String(formatter.string(from: number) ?? "")
    }
}
