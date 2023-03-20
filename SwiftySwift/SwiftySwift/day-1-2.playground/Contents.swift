import Cocoa

var greeting = "Hello, playground"

let number = 0.1 + 0.2

print(number)

var myInt = 1
var myDouble = 2.0

//let myTotal = myInt + myDouble  // error: binary operator '+' cannot be applied to operands of type 'Int' and 'Double'

print (Double(myInt) + myDouble)


var name = "Taylor"
var age = 20

//print (name + "years old " + age)   // not allowed for type safety
print (name + " years old " + String(age))   // allowed
print ("\(name) is \(age) years old" )  // fastest


let daysInAWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
var arrInt : [Int] = [1,2,3,4,5,1_0_0]
let fibonacci = [0, 1, 1, 2, 3, 5, 8.0]

var lastFibo = fibonacci[6]
print("last fibo \(lastFibo)")

print ("for loop")
for item in arrInt {  // can exit the loop if desired
    print(item)
}

print ("for each loop")
arrInt.forEach {  // Processes all items
    print($0)
}


// different types of Array declarations
//var emptyArr : [String] = []   // var emptyArr = [String]()    // var emptyArr = Array<String>()
//var emptyArr = [String]()
var emptyArr = Array<String>()
emptyArr.append("hello there")
emptyArr.forEach { str in
    print(str)
}


/* Dictionary */

var dict = [
    "key1": ["arr1", "brr1"],
    "key2": ["arr2", "brr2"],
    "key3": ["arr3", "brr3"],
    "key4": ["arr4", "brr4"]
]

dict.forEach { keyValue in
    print("Item = \(keyValue)")
}


/* Sets vs. Array - Sets are very fast. No duplicates, and items are 'Inserted' whereas items 'appended in Arrays.
 Also Set items are retrieved in no specific order

 sets are unordered and cannot contain duplicates, whereas arrays retain their order and can contain duplicates.
 */

var setEg = Set(["Michael", "Tom", "Jack", "Roman"])
setEg.forEach { str in
    print("\(str)")
}

setEg.forEach {
    print("\($0)")
}


/* Enums are saved as highly optimized data
Enums are safe to use */
enum Weekdays {
    case Mon, Tue, Wed, Thu, Fri, Sat, Sun
}

var day = Weekdays.Fri
day = .Thu
print("Day = \(day)")
