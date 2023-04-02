//
//  ExpenseItem.swift
//  SwiftySwift
//
//  Created by Amit on 2023-03-30.
//

import Foundation

struct ExpenseItem : Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
