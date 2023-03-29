//
//  WeSplit.swift
//  SwiftySwift
//
//  Created by Amit on 2023-03-28.
//

import SwiftUI

struct WeSplit: View {

        /* any change to State variables will refresh the UI aka. re-invoke the 'Body' property */
        @State private var checkAmount = 0.0
        @State private var numberOfPeople = 3
        @State private var tipPercentage = 20

        @FocusState private var isAmountSelected

        let tipPercentages = [10, 15, 20, 25, 0]

        var mySplit : Double {
            calculateTotalToPay()
        }

        var totalPayable : Double {
            mySplit * Double(numberOfPeople + 2)
        }

        var body: some View {

            NavigationView {
                Form {
                    Section {
                        TextField("Amount", value: $checkAmount, format:.currency(code: Locale.current.currencyCode ?? "USD"))
                            .keyboardType(.decimalPad)
                            .focused($isAmountSelected)

                        Picker("Number of People", selection: $numberOfPeople) {
                            ForEach (2..<100) {
                                Text("\($0) people")
                            }
                        }
                    }
                    Section {
                        Picker("Tip percentage", selection: $tipPercentage) {
                            ForEach (tipPercentages, id:\.self) {
                                Text("\($0) %")
                            }
                        }
                        .pickerStyle(.segmented)
                    }

                    Section {
                        Text("Total Amount Payable")
                            .background(.clear)
                            .foregroundColor(tipPercentage == 0 ? .red : .blue)
                        Text(totalPayable, format:.currency(code: Locale.current.currencyCode ?? "USD"))
                    }

                    Section {
                        Text("Amount Per Person")
                            .background(.clear)
                            .foregroundColor(.blue)
                        Text(mySplit, format:.currency(code: Locale.current.currencyCode ?? "USD"))
                    }
                }
                .navigationTitle("WeSplit")
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            isAmountSelected = false
                        }
                    }
                }
            }
        }

        func calculateTotalToPay() -> Double {

            let peopleCount = Double(numberOfPeople + 2)
            let tipSelection = Double(tipPercentage)
            let tipValue = checkAmount / 100 * tipSelection

            let grandTotal = checkAmount + tipValue
            let amoutPerPerson = grandTotal / peopleCount

            return amoutPerPerson
        }
    }

struct WeSplit_Previews: PreviewProvider {
    static var previews: some View {
        WeSplit()
    }
}
