//
//  iExpense.swift
//  SwiftySwift
//
//  Created by Amit on 2023-03-29.
//

import SwiftUI

struct iExpense: View {

    @StateObject var expenses = Expenses()
    @State private var showAddExpense = false

    var body: some View {

        NavigationView {
            List {
                //ForEach(expenses.items, id: \.id) { item in
                ForEach(expenses.items) { item in

                    HStack {

                        VStack(alignment: .leading) {
                            Text(item.name)
                            Text(item.type)
                        }
                        .padding(10)

                        Spacer()

                        Text("\(item.amount)")
                    }

                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button ("add") {

                    showAddExpense = true

//                    let expense = ExpenseItem(name: "something", type: "else", amount: 10.0)
//                    expenses.items.append(expense)
                }
            }
        }
        .sheet(isPresented: $showAddExpense) {
            AddView(expenses: expenses)
        }
    }

    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct iExpense_Previews: PreviewProvider {
    static var previews: some View {
        iExpense()
    }
}
