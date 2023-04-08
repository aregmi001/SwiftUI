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



struct UserStruct {
    var firstName = "Bilbo"
    var lastName = "Baggins"
}

struct UserToPersist: Codable {
    let firstName: String
    let lastName: String
}

class UserClass : ObservableObject {
    @Published var firstName = "Bilbo"
    @Published var lastName = "Baggins"
}

struct SecondView: View {
    @Environment(\.dismiss) var dismissRR
    let name: String

    var body: some View {
        Text("Hello, \(name)!")
        Button("Dismiss") {
            dismissRR()
        }
    }
}

struct iExpense22: View {

    @State private var userStructState = UserStruct()
    @StateObject private var userClassStateObj = UserClass()
    @State private var isPresentSheet = false

    @State private var numbers = [Int]()
    //@State private var currentNumber = UserDefaults.standard.integer(forKey: "tapcount")

    @AppStorage("currentNumber") private var currentNumber = 0

    @State private var user = UserToPersist(firstName: "Taylor", lastName: "Swift")


    var body: some View {

        NavigationView {

            VStack {
                VStack {
                    Text("( Struct State property )  \(userStructState.firstName) \(userStructState.lastName).")

                    TextField("First name", text: $userStructState.firstName)
                    TextField("Last name", text: $userStructState.lastName)
                }
                .padding()
                .background(.red)
                .foregroundColor(.white)

                VStack {
                    Text("( Class StateObject property )  \(userClassStateObj.firstName) \(userClassStateObj.lastName).")

                    TextField("First name", text: $userClassStateObj.firstName)
                    TextField("Last name", text: $userClassStateObj.lastName)
                }
                .padding()
                .background(.blue)
                .foregroundColor(.white)


                VStack {
                    Text("( Testing Sheets )  \(userClassStateObj.firstName) \(userClassStateObj.lastName).")

                    Button("Launch Sheet") {
                        isPresentSheet.toggle()
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                }
                .padding()
                .background(.gray)
                .foregroundColor(.white)
                .sheet(isPresented: $isPresentSheet) {
                    // return the view that will show
                    SecondView(name: "Amie")
                }

                VStack {
                    Text("( Testing List )")

                    Button("Add To Row") {
                        numbers.append(currentNumber)
                        currentNumber += 1

                        //UserDefaults.standard.set(currentNumber, forKey: "tapcount")
                    }
                    List {
                        ForEach(numbers, id: \.self) {
                            Text("\($0)")
                        }
                        .onDelete(perform: removeRows)
                    }

                    Button("Save User") {
                        let encoder = JSONEncoder()

                        if let data = try? encoder.encode(user) {
                            UserDefaults.standard.set(data, forKey: "UserData")
                        }
                    }
                }
                .toolbar {
                    EditButton()
                }
            }
        }
    }

    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}



struct ListViewRow : View {
    private var rowIndex = 0
    private var rowText = ""
    var body: some View {
        Text("\(rowIndex) : \(rowText)")
    }

    init(rowIndex: Int , rowText: String = "") {
        self.rowIndex = rowIndex
        self.rowText = rowText
        print("Row \(rowIndex) Created")
    }
}

struct Moonshot33: View {

//    let layout = [
//        GridItem(.fixed(80)),
//        GridItem(.fixed(80)),
//        GridItem(.fixed(80))
//    ]

    let layout = [
        GridItem(.adaptive(minimum: 80, maximum: 120)),
        GridItem(.adaptive(minimum: 80, maximum: 120)),
        GridItem(.adaptive(minimum: 80, maximum: 120))
    ]

    var body: some View {

//        GeometryReader { item in
//            Image("tor")
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(width: 300, height: 300)
//                .frame(width: item.size.width, height: item.size.height)
//        }

        NavigationView {

            VStack {
                ScrollView {
                    LazyVStack {
                        ForEach(0..<100) {rowIndex in

                            NavigationLink {
                                Text("Detail view for row \(rowIndex)")
                            } label: {
                                ListViewRow(rowIndex: rowIndex, rowText: "Sample Row")
                            }
                        }
                    }
                }
                .navigationTitle("Hello Scroll")
                .background(.red)

                ScrollView {
                    LazyVGrid(columns: layout) {
                        ForEach(0..<1000) {rowIndex in
                            Text("Item \(rowIndex)")
                        }
                    }
                }
                .navigationTitle("Grid Scroll")
                .background(.blue)
            }
        }
    }
}

struct Response99: Codable {
    var results : [Result99]
}

struct Result99: Codable {
    var trackId: Int
    var trackName : String
    var collectionName: String
}

//final class User : ObservableObject, Codable {
//
//    enum CodingKeys : CodingKey {
//        case name
//    }
//
//    @Published var name: String = "Taylor Swift"
//
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        name = try container.decode(String.self, forKey: .name)
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encodeIfPresent(name, forKey: .name)
//    }
//}

struct CupcakeCorner55: View {

    @State private var results = [Result99]()
    @State private var username = ""
    @State private var email = ""

    var disableForm: Bool {
        username.count < 5 || email.count < 5
    }

    var body: some View {

        VStack {

            Form {
                Section {
                    TextField("Username", text: $username)
                    TextField("Email", text: $email)
                }

                Section {
                    Button("Create account") {
                        print("Creating account…")
                    }
                    .disabled(disableForm)
                }
            }


            AsyncImage(url: URL(string: "https://res.cloudinary.com/demo/image/upload/v1312461204/sample.jpg")) { phase in


                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                } else if phase.error != nil {
                    Text("There was an error")
                } else {
                    ProgressView()
                }
            }

//                phase
//                    .resizable()
//                    .scaledToFit()

//            } placeholder: {
//                // Color.red
//                ProgressView()
//            }
//            .frame(width: 300, height: 300)

            List(results, id: \.trackId) { item in

                VStack(alignment: .leading) {

                    Text(item.trackName)
                        .font(.headline)
                    Text(item.collectionName)
                }
            }
            .task {
                await loadData()
            }
        }
    }

    func loadData() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print ("invalid URL")
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            // more code to come

            if let decodedResponse = try?  JSONDecoder().decode(Response99.self, from: data) {
                results = decodedResponse.results
            }
        } catch {
            print ("Invalid data ")
        }
    }
}

import CoreImage
import CoreImage.CIFilterBuiltins

struct Instafilter88: View {

    @State private var image: Image?

    var body: some View {

        VStack {
            image?
                .resizable()
                .scaledToFit()
        }
        .onAppear(perform: loadImage)
    }

    func loadImage() {
        //image = Image("aldrin")
        guard let inputImage = UIImage(named: "aldrin") else { return }
        let beginImage = CIImage(image: inputImage)

        let context = CIContext()

        let currentFilter = CIFilter.sepiaTone()

        currentFilter.inputImage = beginImage
        currentFilter.intensity = 1

        guard let outputImage = currentFilter.outputImage else {return}

        if let cgImg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgImg)

            image = Image(uiImage: uiImage)
        }
    }
}

struct Instafilter99: View {

    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var showingImagePicker = false

    var body: some View {
        VStack{
            image?
                .resizable()
                .scaledToFit()

            Button("Select Image") {
                showingImagePicker = true
            }

            Button("Save Image") {
                guard let inputImage = inputImage else { return }
                let imageSaver = ImageSaver()
                imageSaver.writeToPhotoAlbum(image: inputImage)
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
        .onChange(of: inputImage) { _ in
            loadImage()
        }
    }

    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
}


/*

 View Hierarchy :
            HotProspects
                -> ChildView1
                    -> ChildView2
                        -> ChildView3

 Pass 'scoreObsObj' to all child view 3 levels and Edit from ChildView3
 Pass 'userEnvObj' to all child view 3 levels and Edit from ChildView2

 */

@MainActor class ScoreObsObj: ObservableObject {
    @Published var score = 0
}

@MainActor class UserEnvObj: ObservableObject {
    @Published var name = "Taylor Swift"
}

struct ChildView3: View {

    @EnvironmentObject var userEnvObj: UserEnvObj
    @ObservedObject var scoreObsObj: ScoreObsObj

    var body: some View {

        VStack {
            Text("ChildView3 \(userEnvObj.name)")
            Text("ChildView3 score = \(scoreObsObj.score)")
        }
        .padding()
        .background(.green)
        .foregroundColor(.white)
        .onAppear(perform: updateScore)
        .onTapGesture { updateScore() }
    }

    func updateScore() {
        scoreObsObj.score = Int.random(in: 0...6)
    }
}

struct ChildView2: View {
    @EnvironmentObject var userEnvObj: UserEnvObj
    @ObservedObject var scoreObsObj: ScoreObsObj

    var body: some View {
        VStack {
            Text("ChildView2 \(userEnvObj.name)")
            ChildView3(scoreObsObj: scoreObsObj)
            TextField("Type Name", text: $userEnvObj.name)
        }
        .padding()
        .background(.blue)
        .foregroundColor(.white)
    }
}

struct ChildView1: View {

    @ObservedObject var scoreObsObj: ScoreObsObj

    var body: some View {

        VStack {
            Text("ChildView1 (score = \(scoreObsObj.score) )")
            ChildView2(scoreObsObj: scoreObsObj)
        }
        .padding()
        .background(.red)
        .foregroundColor(.white)
    }
}

struct HotProspects99: View {

    @StateObject private var userEnvObj = UserEnvObj()
    @StateObject var scoreObsObj = ScoreObsObj()

    var body: some View {
        VStack {
            ChildView1(scoreObsObj: scoreObsObj)
        }
        .padding()
        .environmentObject(userEnvObj)
    }
}


/* Manually publishing ObservableObject changes */

@MainActor class DelayedUpdater: ObservableObject {

    var value = 0 {
        willSet {
            /* do more things here before sending update */
            objectWillChange.send()
        }
    }

    init() {
        for i in 1...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.value += 1
            }
        }
    }
}

struct HotProspects999: View {
    @StateObject var updater = DelayedUpdater()

    var body: some View {
        Text("Value is: \(updater.value)")
    }
}
