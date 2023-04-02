//
//  AddView.swift
//  SwiftySwift
//
//  Created by Amit on 2023-03-30.
//

import SwiftUI

struct AddView: View {

    @ObservedObject var expenses: Expenses
    @Environment(\.dismiss) var dismissRR

    @State private var name = ""
    @State private var type = ""
    @State private var amount = 10.0

    let types = ["Business", "Personal"]

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Select Type", selection: $type) {
                    ForEach(types, id: \.self){
                        Text("\($0)")
                    }
                }

                TextField("Amount", value: $amount, format: .currency(code: "USD"))
            }
            .navigationTitle("Add New Expense")
            .toolbar {
                Button ("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(item)
                    dismissRR()
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
