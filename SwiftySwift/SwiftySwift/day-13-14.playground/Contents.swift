import Cocoa

var greeting = "Hello, playground"

/* Protocols */

protocol Vehicle {
    var name: String { get }
    var currentPassengers: Int { get set }
    func estimateTime(for distance: Int) -> Int
    func travel(distance: Int)
}

struct Car: Vehicle {
    let name = "Car"
    var currentPassengers = 1

    func estimateTime(for distance: Int) -> Int {
        distance / 50
    }

    func travel(distance: Int) {
        print("I'm driving \(distance)km.")
    }

    func openSunroof() {
        print("It's a nice day!")
    }
}

struct Bicycle: Vehicle {
    let name = "Bicycle"
    var currentPassengers = 1

    func estimateTime(for distance: Int) -> Int {
        distance / 10
    }

    func travel(distance: Int) {
        print("I'm cycling \(distance)km.")
    }
}

func commute(distance: Int, using vehicle: Vehicle) {
    if vehicle.estimateTime(for: distance) > 100 {
        print("That's too slow! I'll try a different vehicle.")
    } else {
        vehicle.travel(distance: distance)
    }
}

let car = Car()
commute(distance: 100, using: car)

let bike = Bicycle()
commute(distance: 50, using: bike)

func getTravelEstimates(using vehicles: [Vehicle], distance: Int) {
    for vehicle in vehicles {
        let estimate = vehicle.estimateTime(for: distance)
        print("\(vehicle.name): \(estimate) hours to travel \(distance)km")
    }
}

getTravelEstimates(using: [car, bike], distance: 150)

/* How to use opaque return types */

func getRandomNumber() -> some Equatable {
    Int.random(in: 1...6)
}

func getRandomBool() -> some Equatable {
    Bool.random()
}

print(getRandomNumber() == getRandomNumber())

// struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
// }

/* Extensions */

struct Book {
    let title: String
    let pageCount: Int
    let readingHours: Int
}

extension Book {
    init(title: String, pageCount: Int) {   // Putting init in Extension, the Base struct will have the
                                            // Automatic initializer
        self.title = title
        self.pageCount = pageCount
        self.readingHours = pageCount / 50
    }
}

let lotr = Book(title: "Lord of the Rings", pageCount: 1178, readingHours: 24)


/* Protocol Extensions */

extension Collection {
    var isNotEmpty: Bool {
        isEmpty == false
    }
}

protocol Person {
    var name: String { get }
    func sayHello()
}

// More importantly, by extending the protocol we’re adding functionality
// that would otherwise need to be done inside individual structs.
// This is really powerful, and leads to a technique Apple calls protocol-oriented programming

extension Person {   // can hold the implementation
    func sayHello() {
        print("Hi, I'm \(name)")
    }
}

struct Employee: Person {
    let name: String
}

let guests = ["Mario", "Luigi", "Peach"]

if guests.isNotEmpty {
    print("Guest count: \(guests.count)")
}

let taylor = Employee(name: "Taylor Swift")
taylor.sayHello()

let numbers3 = ["four": 4, "eight": 8, "fifteen": 15, "sixteen": 16]
let allEven3 = numbers3.allSatisfy { $0.value.isMultiple(of: 2) }



/* Optionals */

func getUsername() -> String? {
    "Taylor"
}

if let usrname = getUsername() {
    print ("we have a non nil username \(usrname)")
}

/* if let and guard let to UnWrap Optionals  */

// So, use if let if you just want to unwrap some optionals,
// but prefer guard let if you’re specifically checking
// that conditions are correct before continuing.


func printSquare(of number: Int?) {
    guard let number = number else {
        print("Missing input")
        return
    }

    print("\(number) x \(number) is \(number * number)")
}


//Remember, reading a dictionary key will always return an optional, so you might want to use nil coalescing here to ensure you get back a non-optional:

let scores = ["Picard": 800, "Data": 7000, "Troi": 900]
let crusherScore = scores["Crusher"] ?? 0
//This is definitely a matter of taste, but dictionaries offer a slightly different approach that lets us specify the default value for when the key isn’t found:

//let crusherScore = scores["Crusher", default: 0]

let lightsaberColor: String? = "green"
let color = lightsaberColor ?? "blue"

//var conferenceName: String? = "WWDC"
//var conference: String = conferenceName ?? nil


/* optional chaining */
// optional chaining lets us dig through several layers of optionals in a single line of code, and if any one of those layers is nil then the whole line becomes nil.

struct Book22 {
    let title: String
    let author: String?
}

var book: Book22? = nil
let author = book?.author?.first?.uppercased() ?? "A"
print(author)


/* handle function failure with optionals */
/* Optional 'try' */
enum UserError: Error {
    case badID, networkFailed
}

func getUser(id: Int) throws -> String {
    throw UserError.networkFailed
}

if let user = try? getUser(id: 23) {
    print("User: \(user)")
}


let user = (try? getUser(id: 23)) ?? "Anonymous"
print(user)

//try? is mainly used in three places:
//
//In combination with guard let to exit the current function if the try? call returns nil.
//In combination with nil coalescing to attempt something or provide a default value on failure.
//When calling any throwing function without a return value, when you genuinely don’t care if it succeeded or not – maybe you’re writing to a log file or sending analytics to a server, for example.

func runRiskyFunction() throws -> String? {
    "hello str"
}

do {
    let result = try runRiskyFunction()
    print(result)
} catch {
    // it failed!
}

if let result = try? runRiskyFunction() {
    print(result)
}


/* checkpoint 9 */

func returnIntegerFromArray(intArr : [Int]?) -> Int {
    return intArr?[Int.random(in: 0..<(intArr?.count ?? 0))] ?? Int.random(in: 1...100)
}

print (" int returned \( returnIntegerFromArray(intArr: [1, 3, 5, 6, 7, 88, 55, 32, 45, 12]))")
print (" int returned \( returnIntegerFromArray(intArr: nil))")
