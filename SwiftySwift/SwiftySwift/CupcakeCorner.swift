//
//  CupcakeCorner.swift
//  SwiftySwift
//
//  Created by Amit on 2023-03-31.
//

import SwiftUI

struct CupcakeCorner: View {

    @StateObject var order = Order()

    var body: some View {

        NavigationView{
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.type) {

                        ForEach(Order.types.indices){
                            Text(Order.types[$0])
                        }
                    }

                    Stepper("Number of cakes: \(order.quantity)", value: $order.quantity, in: 3...20)
                }

                Section("special request") {

                    Toggle("Any special request?", isOn: $order.specialRequestEnabled.animation())

                    if  order.specialRequestEnabled {
                        Toggle("Add Extra frosting", isOn: $order.extraFrosting)
                        Toggle("Add extra sprinkles ", isOn: $order.addSprinkles)
                    }
                }

                Section("hello") {

                    NavigationLink {
                        AddressView(order: order)
                    } label: {
                        Text("Deliver to Address")
                    }
                }
            }
        }
    }
}

struct CupcakeCorner_Previews: PreviewProvider {
    static var previews: some View {
        CupcakeCorner()
    }
}
