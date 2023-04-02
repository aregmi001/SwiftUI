//
//  CheckoutView.swift
//  SwiftySwift
//
//  Created by Amit on 2023-04-01.
//

import SwiftUI

struct CheckoutView: View {

    @ObservedObject var order: Order
    @State private var isShowConfirmation = false
    @State private var confirmationMsg = ""

    var body: some View {

        ScrollView {
            VStack {
                AsyncImage(url:  URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in

                    image
                        .resizable()
                        .scaledToFit()

                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)

                Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)

                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Check Out")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Thank You", isPresented: $isShowConfirmation) {
            Button("Ok") {}
        } message: {
            Text("\(confirmationMsg)")
        }
    }

    func placeOrder() async {

        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }

        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)

            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMsg = "Your order for \(decodedOrder.quantity) \(Order.types[decodedOrder.type].lowercased()) cupcakes is on it's way!"
            isShowConfirmation = true

        } catch {
            print ("Checkout Failed ")
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
