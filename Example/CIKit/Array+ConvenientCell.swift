//
//  Array+ConvenientCell.swift
//  ConvenientCell
//
//  Created by Feiyou Guo on 9/4/20.
//  Copyright © 2020 Exquisitian. All rights reserved.
//

import Foundation

extension Array {
    var powerset: [[Element]] {
        guard count > 0 else { return [[]] }

        // tail contains the whole array BUT the first element
        let tail = Array(self[1..<endIndex])

        // head contains only the first element
        let head = self[0]

        // computing the tail's powerset
        let withoutHead = tail.powerset

        // mergin the head with the tail's powerset
        let withHead = withoutHead.map { $0 + [head] }

        // returning the tail's powerset and the just computed withHead array
        return withHead + withoutHead
    }
}
