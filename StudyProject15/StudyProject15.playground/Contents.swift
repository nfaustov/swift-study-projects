import Foundation

// MARK: Sorted ascending array -
let array = [6, 2, 8, 4, 9, 1, 7, 3, 5]
let sortedArray = array.sorted(by: { $0 < $1 })
print(sortedArray)

// MARK: Int array mapped in string array -
let stringArray = array.map { String($0) }
print(stringArray)

// MARK: String array transformed in single string -
let namesArray = ["John", "Anna", "Michael", "Peter", "Monica"]
let namesString = namesArray.reduce("", +)
print(namesString)

// MARK: Function executes other function with a delay of 2 seconds -
func execute(function: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
        function()
    }
}

execute {
    print("It works!")
}

// MARK: Function returns other function executes two input functions when called -
func execute(function: @escaping () -> Void, completion: @escaping () -> Void) -> () -> Void {
    return {
        function()
        completion()
    }
}

let mainFunction = execute {
    print("function1 works!")
} completion: {
    print("function2 works!")
}

mainFunction()

// MARK: Sorted array by specified algorithm -
func sorter(_ array: [Int], by: (Int, Int) -> Bool) -> [Int] {
    guard array.count > 1 else { return array }
    
    var sortedArray = array
    
    for index in 1..<sortedArray.count {
        var currentIndex = index
        let temp = sortedArray[currentIndex]
        
        while currentIndex > 0 && by(temp, sortedArray[currentIndex - 1]) {
            sortedArray[currentIndex] = sortedArray[currentIndex - 1]
            currentIndex -= 1
        }
        
        sortedArray[currentIndex] = temp
    }
    return sortedArray
}

let arrayBySorter = sorter(array, by: >)
print(arrayBySorter)

