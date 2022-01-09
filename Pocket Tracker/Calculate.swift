//
//  Calculate.swift
//  Pocket Tracker
//
//  Created by Yinan An on 1/9/22.
//

import SwiftUI

class Calculate {
    func GetSeperateSum(records: FetchedResults<Record>) -> Array<String> {
        var categories = GlobalVariables().categories
        var expenses = Array(repeating: 0.0, count: GlobalVariables().categories.count)
        for record in records {
            let index = categories.firstIndex(of: record.category ?? "Other")
            expenses[index!] += record.amount
        }
        for i in 0 ... categories.count-1 {
            categories[i] += ": "
            categories[i] += String(format: "%.2f", expenses[i])
        }
        return categories
    }
}
