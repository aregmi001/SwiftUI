//
//  PracticeUI.swift
//  SwiftySwift
//
//  Created by Amit on 2023-03-28.
//

import SwiftUI

struct PracticeUI: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct PracticeUI_Previews: PreviewProvider {
    static var previews: some View {
        Practice2()
    }
}

struct TestSwiftUIView: View {

    @State var tapCount: Int = 0
    @State private var name: String = ""
    let students = ["Harry", "Meghan", "Ron"]
    @State private var selectedStudent = "Harry"

    var body: some View {
//
//        NavigationView {
//            Form {
//
////                Group {
////                    Text("Hello World")
////                    Text("Hello World")
////                }
//
//                Section {
//                    Text("Section Text")
//                }
//
////                Group {
////                    Text("Hello World")
////                    Text("Pello World")
////                }
//            }
//        }
//        .navigationTitle("Nav Title")
//        .navigationBarTitleDisplayMode(.inline)

        NavigationView {

            VStack {

                Spacer()

                Text ("Tapped \(tapCount)")

                Button("Tap me"){
                    tapCount += 1
                }

                Form {
                    TextField("Enter Name", text: $name) {
                        print("Entered Text \(name)")
                    }

                    Text ("\(name)")

                    ForEach(0..<3) {
                        Text("Row \($0)")
                    }
                }

                NavigationView {
                    Form {
                        Picker("Select student", selection: $selectedStudent) {

                            ForEach(students, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                }
            }
        }
        .background(.black)
        .foregroundColor(.red)
        .navigationTitle("Nav title")

    }
}

struct Practice2: View {

    @State private var showingAlert = false

    var body: some View {

//        ZStack{
//            VStack(spacing: 0) {
//                Color.gray
//                Color.red
//            }
//
//            /* check on light and dark mode - ( Command + Shift + A ) to switch*/
//            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//                .foregroundStyle(.secondary)
//                .padding(30)
//                .background(.ultraThinMaterial)
//        }
//        .ignoresSafeArea()


        //LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .top, endPoint: .bottom)

        VStack {
            Button("Button 1") { }
                .buttonStyle(.bordered)
            Button("Button 2", role: .destructive) { }
                .buttonStyle(.bordered)
            Button("Button 3") { }
                .buttonStyle(.borderedProminent)
            Button("Button 4", role: .destructive) { }
                .buttonStyle(.borderedProminent)


            /* custom button */
            Button {
                showingAlert = true
            } label: {
//                Text("Tap Me!")
//                    .padding()
//                    .foregroundColor(.white)
//                    .background(.red)

                Label("Edit", systemImage: "pencil")
            }
            .alert("Import Message", isPresented: $showingAlert, actions: {

                Button("Delete", role: .destructive) {

                }

                Button("Cancel", role: .cancel) {

                }

            }, message: {
                Text(" Hello Message ")
            })

//            Image(systemName: "pencil")
        }

    }
}


struct BetterRest33: View {

    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date.now

    var body: some View {

        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            //Stepper("\(sleepAmount) hours", value: $sleepAmount)
            Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                .padding()

            //DatePicker("Please enter a date", selection: $wakeUp)
            DatePicker("Please enter a date", selection: $wakeUp)
                .labelsHidden()

            DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)

            DatePicker("Please enter a date", selection: $wakeUp, in: Date.now...)

//            let now = Date.now
//            let tomorrow = Date.now.addingTimeInterval(86400)
//            let range = now...tomorrow
//
//            var components1 = DateComponents()
//            components1.hour = 8
//            components1.minute = 0
//            //let date = Calendar.current.date(from: components)
//
//            let date22 = Calendar.current.date(from: components1) ?? Date.now
//
//            let components = Calendar.current.dateComponents([.hour, .minute], from: date22)
//            let hour = components.hour ?? 0
//            let minute = components.minute ?? 0


            Text(Date.now, format: .dateTime.hour().minute())
            Text(Date.now, format: .dateTime.day().month().year())
            Text(Date.now.formatted(date: .long, time: .shortened))

        }
    }

    func exampleDates() {

        // create a second Date instance set to one day in seconds from now
        let tomorrow = Date.now.addingTimeInterval(86400)

        // create a range from those two
        _ = Date.now...tomorrow
    }
}

struct WordScramble11: View {

    let people = ["Finn", "Huckle", "Barry"]
    var body: some View {
        VStack{
            List {

                ForEach(people, id: \.self) {
                    Text($0)
                }

                Text("Hello World")
                Text("Hello ")
            }
            List {

                Section("header ") {
                    Text("Hello World")
                }

                ForEach(0..<5) {
                    Text("Dynamic row \($0)")
                }
            }
            .listStyle(.grouped)
        }
    }
}
