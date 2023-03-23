import Cocoa

var greeting = "Hello, playground"


/* functions - if it has only ONE line of code - we don't need 'return' keyword */

func findIfStringsSimilar(str1: String, str2: String) -> Bool {

    let sortedStr1Set = Set(str1).sorted()
    let sortedStr2Set = Set(str2).sorted()

    if sortedStr1Set.count != sortedStr2Set.count {
        return false
    } else {
        /* equal number of sorted chars */
        for i in 0..<sortedStr2Set.count {
            if sortedStr2Set[i] != sortedStr1Set[i] {
                return false
            }
        }
        return true
    }
}

func pythagoras(a: Double, b: Double) -> Double {
    sqrt(a * a + b * b)
}

print (findIfStringsSimilar(str1: "ABCDEFG", str2: "AABBCCDDEEFFGGH"))
print ("pythagoras 3, 4 = \(pythagoras(a: 3, b: 4))")

/* tuples */

func getUser() -> (firstName: String, lastName: String) {
    //(firstName: "Taylor", lastName: "Swift")
    ("Taylor", "Swift")
}

let user = getUser()
let firstName = user.firstName
let lastName = user.lastName

print("Name: \(firstName) \(lastName)")

let (fName, _) = getUser()   // if we don't need the second value
print("Name: \(fName)")


/* External vs. Internal Parameter names */
func printTimesTables(for number: Int) {
    for i in 1...12 {
        print("\(i) x \(number) is \(i * number)")
    }
}

printTimesTables(for: 5)

func isUppercase(_ string: String) -> Bool {   // not using external name
    string == string.uppercased()
}

let string = "HELLO, WORLD"
let result = isUppercase(string)


/* Default Params */
func printTimesTables(for number: Int, end: Int = 12) {
    for i in 1...end {
        print("\(i) x \(number) is \(i * number)")
    }
}

printTimesTables(for: 5, end: 8)
printTimesTables(for: 8)


/* Error Handling with 'throws' */

enum PasswordError: Error {
    case short, obvious
}

func checkPassword(_ password: String) throws -> String {
    if password.count < 5 {
        throw PasswordError.short
    }

    if password == "12345" {
        throw PasswordError.obvious
    }

    if password.count < 8 {
        return "OK"
    } else if password.count < 10 {
        return "Good"
    } else {
        return "Excellent"
    }
}

let str1 = "12345"

do {
    let result = try checkPassword(str1)
        // use try!  if you are 100% sure it wont throw Error. You won't need "Do' and "Catch" if so.
    print("Password rating: \(result)")
} catch PasswordError.short {
    print("Please use a longer password.")
} catch PasswordError.obvious {
    print("I have the same combination on my luggage! ")
} catch {
    print("There was an error. \(error.localizedDescription)")
}


/* find sqrt without using sqrt function */

enum SqrtError: Error {
    case outOfBounds, noRootFound
}

func mySqrt(number: Int) throws -> Int {

    if number < 1 || number > 10_000 {
        throw SqrtError.outOfBounds
    }

    for i in 1...100 {
        if  i * i == number {
            return i
        }
    }

    throw SqrtError.noRootFound
}

print(mySqrt(number: 4))

do {
    let sqrtValue = try mySqrt(number: 19)
    print("sqrt of 9 = \(sqrtValue)")
} catch SqrtError.noRootFound {
    print ("No root found")
} catch SqrtError.outOfBounds {
    print ("Out of Bounds")
}

//print(mySqrt(number: -14))


/* closures */

func helloUser () -> String {
    return "User hi"
}

var newFunction = helloUser
var newFunction2 : () -> String = helloUser
//var newFunction3 : () -> () = helloUser    // () => means Void. Use Void instead of ()
print(newFunction())


func getUserDataaa(for id: Int) -> String {
    if id == 1989 {
        return "Taylor Swift"
    } else {
        return "Anonymous"
    }
}

let data: (Int) -> String = getUserDataaa
let userrr = data(1989)
print(userrr)

let team = ["Gloria", "Suzanne", "Piper", "Tiffany", "Tasha"]
let sortedTeam = team.sorted()
print(sortedTeam)

func captainFirstSorted(name1: String, name2: String) -> Bool {
    if name1 == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }

    return name1 < name2
}

//let captainFirstTeam = team.sorted(by: captainFirstSorted)
//print(captainFirstTeam)

let captainFirstTeam = team.sorted(by: { (name1: String, name2: String) -> Bool in
    if name1 == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }

    return name1 < name2
})

let captainFirstTeam2 = team.sorted {
    if $0 == "Suzanne" {
        return true
    } else if $1 == "Suzanne" {
        return false
    }

    return $0 < $1
}

let reverseTeam = team.sorted { $0 > $1 }

let tOnly = team.filter { $0.hasPrefix("T") }
print(tOnly)

let uppercaseTeam = team.map { $0.uppercased() }
print(uppercaseTeam)


/* passing closures */

let ClosureAction : () -> Void

func doImportantWork(first: () -> (), second: () -> Void, third: () -> Void) {
    print("About to start first work")
    first()
    print("About to start second work")
    second()
    print("About to start third work")
    third()
    print("Done!")
}

doImportantWork {
    print("In First")
} second: {
    print("In Second")
} third: {
    print("In Third")
}


let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]

//Your job is to:
//
//Filter out any numbers that are even
//Sort the array in ascending order
//Map them to strings in the format “7 is a lucky number”
//Print the resulting array, one item per line
//So, your output should be as follows:
//
//7 is a lucky number
//15 is a lucky number
//21 is a lucky number
//31 is a lucky number
//33 is a lucky number
//49 is a lucky number

print(luckyNumbers)
let filteredArr = luckyNumbers.filter {
    !$0.isMultiple(of: 2)   // returns
}

print(filteredArr)

let sortedArray = filteredArr.sorted()

print(sortedArray)

let modifiedArr = sortedArray.map {
    "\($0) is a lucky number"
}

modifiedArr.forEach { print($0) }
