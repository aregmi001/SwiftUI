import Cocoa

var greeting = "Hello, playground"

/* find number of unique items in array */
var arrStr : [String] = ["zero", "one", "two", "three", "four", "one", "two", "five", "six"]


var dict = [String: String]()
for item in arrStr {
    dict[item] = ""
}

print("Number of items in array = \(arrStr.count), number of unique items = \(dict.keys.count)")

/* another solution is to use Sets. Convert the Array to Sets and print the count */
let mySet = Set(arrStr)
print("Number of items in array = \(arrStr.count), number of unique items = \(mySet.count)")


var username = "michael"
if username.count == 0 {        // this check is very expensive. Checks individual characters. Use username.isEmpty instead.
    username = "Anonymous"
}

print("Welcome \(username)")


enum Sizes: Comparable {
    case small
    case medium
    case large
}

let first = Sizes.small
let second = Sizes.large
print(first < second)

let testEnum: Sizes = .large

let day = 4
print("My true love gave to me…")

switch day {
case 5:
    print("5 golden rings")
    fallthrough
case 4:
    print("4 calling birds")
    fallthrough
case 3:
    print("3 French hens")
    fallthrough
case 2:
    print("2 turtle doves")
    fallthrough
default:
    print("A partridge in a pear tree")
}


let isGreater : Bool = ( 5 > 3 ) ? true : false
print("isGreater = \(isGreater)")

for i in 1...5 {
    print("Counting from 1 through 5: \(i)")
}

print()

for i in 1..<5 {
    print("Counting 1 up to 5: \(i)")
}

var lyric = "Haters gonna"

for _ in 1...5 {    // we don't care about the count variable, coz we don't use it.
    lyric += " hate"
}

print(lyric)


let names = ["Piper", "Alex", "Suzanne", "Gloria"]

print(names[0])
print(names[1...3])
print(names[2...])

// create an integer to store our roll
var roll = 0

// carry on looping until we reach 20
while roll != 20 {
    // roll a new dice and print what it was
    roll = Int.random(in: 1...20)
    print("I rolled a \(roll)")
}

// if we're here it means the loop ended – we got a 20!
print("Critical hit!")


/* Fizz Buzz problem */

for i in 1...1_0_0 {
    if i.isMultiple(of: 5) && i.isMultiple(of: 3) {
        print ("FizzBuzz")
    } else if i.isMultiple(of: 3) {
        print ("Fizz")
    } else if i.isMultiple(of: 5) {
        print ("Buzz")
    } else {
        print ("\(i)")
    }
}
