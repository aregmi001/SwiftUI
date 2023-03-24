import Cocoa

var greeting = "Hello, playground"

/* struct */

struct Employee {
    let name: String
    var vacationRemaining: Int = 14

    mutating func takeVacation(days: Int) {
        if vacationRemaining > days {
            vacationRemaining -= days
            print("I'm going on vacation!")
            print("Days remaining: \(vacationRemaining)")
        } else {
            print("Oops! There aren't enough days remaining.")
        }
    }
}

var archer = Employee(name: "Sterling Arc", vacationRemaining: 13)
var archer2 = Employee.init(name: "Sterling", vacationRemaining: 1)
archer.takeVacation(days: 5)  // this line won't compile if archer is a constant instead of VAR
print(archer.vacationRemaining)


let kane = Employee(name: "Lana Kane")
let poovey = Employee(name: "Pam Poovey", vacationRemaining: 35)


/* Getters and Setters - Dynamic property values */

struct Employee22 {

    /* stored property */
    let name: String
    var vacationAllocated = 14
    var vacationTaken = 0

    /* computed property */
    var vacationRemaining: Int {
        get {
            vacationAllocated - vacationTaken
        }

        set {
            vacationAllocated = vacationTaken + newValue  // newValue stores whatever value user was trying to assign to the property
        }
    }
}

var archer22 = Employee22(name: "Sterling Archer", vacationAllocated: 14)
archer22.vacationTaken += 4
archer22.vacationRemaining = 5
print(archer22.vacationAllocated)


/* property Observers */

struct App {
    var contacts = [String]() {
        willSet {
            print("Current value is: \(contacts)")
            print("New value will be: \(newValue)")
        }

        didSet {
            print("There are now \(contacts.count) contacts.")
            print("Old value was \(oldValue)")
        }
    }
}

var app = App()
app.contacts.append("Adrian E")
app.contacts.append("Allen W")
app.contacts.append("Ish S")


/* custom init */
// as soon as you add a custom initializer for your struct, the default memberwise initializer goes away.
// If you want it to stay, move your custom initializer to an extension, like this:

struct Player {
    let name: String
    let number: Int

    func printSomething() {
        print ("something")
    }
}

extension Player {

    init(name: String) {
        self.name = name
        //printSomething()  //  error: 'self' used before all stored properties are initialized
        number = Int.random(in: 1...99)

        /* calls should follow initialization of ALL the properties */
        printSomething()
    }

    init(name: String, newVar : Double) {
        self.name = name
        number = Int.random(in: 1...99)

        /* calls should follow initialization of ALL the properties */
        print ("Double Value input \(newVar)")
    }
}

let player = Player(name: "Megan R")
let player2 = Player(name: "Megan R", newVar: 1.0)
let player3 = Player(name: "Hello Name", number: 23)
print(player.number)


struct Doctor {
    var name: String
    var location: String
    private var currentPatient = "No one"
}

// error: 'Doctor' initializer is inaccessible due to 'private' protection level
// let drJones = Doctor(name: "Esther Jones", location: "Bristol")


/* Usage of Static Struct - Constants, and Example values  */
struct AppData {
    static let version = "1.3 beta 2"
    static let saveFilename = "settings.json"
    static let homeURL = "https://www.hackingwithswift.com"
}

struct Employee33 {
    let username: String
    let password: String

    static let example = Employee33(username: "cfederighi", password: "hairforceone")
}

struct School {
    static var studentCount = 0

    static func add(student: String) {
        print("\(student) joined the school.")
        Self.studentCount += 1
    }
}

School.add(student: "Ram")


struct Car {
    private let model : String
    private let numberOfSeats : Int

    private var currentGear : Int {
        didSet {
            print("New Gear Value set to \(currentGear)")
        }
    }

    init(model: String, seats: Int, gear: Int) {
        self.model = model
        self.numberOfSeats = seats
        self.currentGear = gear
    }

    mutating func changeGear(gear: Int) {

        if gear > 0 && gear <= 10 {
            self.currentGear = gear
        }
    }

    func getGear() -> Int {
       return self.currentGear
    }
}

var myCar: Car = Car(model: "Honda", seats: 3, gear: 0)
var yourCar = myCar
myCar.changeGear(gear: 2)
myCar.changeGear(gear: 0)
myCar.changeGear(gear: 11)

yourCar.changeGear(gear: 3)
yourCar.changeGear(gear: 7)


/* Classes */

class Employee45 {
    let hours: Int

    init(hours: Int) {
        self.hours = hours
    }

    func printSummary() {
        print("I work \(hours) hours a day.")
    }
}

final class Developer: Employee45 {
    func work() {
        print("I'm writing code for \(hours) hours.")
    }
}

class Manager: Employee45 {
    func work() {
        print("I'm going to meetings for \(hours) hours.")
    }

    override func printSummary() {
        print("I'm a developer who will sometimes work \(hours) hours a day, but other times spend hours arguing about whether code should be indented using tabs or spaces.")
    }
}

//class FontendDeveloper: Developer {  // can not inherit from a 'final' class
//    func work() {
//        print("I'm writing code for \(hours) hours.")
//    }
//}

let robert = Developer(hours: 8)
let joseph = Manager(hours: 10)
robert.work()
joseph.work()

let novall = Developer(hours: 8)
novall.printSummary()


// InHerit
class Vehicle {
    let isElectric: Bool

    init(isElectric: Bool) {
        self.isElectric = isElectric
    }
}

class Jeep: Vehicle {
    let isConvertible: Bool

    init(isElectric: Bool, isConvertible: Bool) {
        self.isConvertible = isConvertible
        super.init(isElectric: isElectric)
    }
}

let teslaX = Jeep(isElectric: true, isConvertible: false)


class User211 {
    var username = "Anonymous"

    func copy() -> User211 {
        let user = User211()
        user.username = username
        return user
    }
}

var user1 = User211()

var user2 = user1.copy()
user2.username = "Taylor"

print(user1.username)
print(user2.username)
