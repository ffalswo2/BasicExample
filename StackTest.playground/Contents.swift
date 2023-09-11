import UIKit

func address(of object: UnsafeRawPointer) -> String {
    let address = Int(bitPattern: object)
    return String(format: "%p", address)
}

struct stack<T> {
    var elemensts: [T] = []

    var isEmpty: Bool {
        elemensts.isEmpty
    }

    mutating func push(element: T) {
        elemensts.append(element)
    }

    @discardableResult
    mutating func pop() -> T? {
        elemensts.popLast()
    }

    func peek() -> T? {
        elemensts.last
    }

}


var s = stack<Int>()
address(of: &s.elemensts)

s.push(element: 10)
address(of: &s.elemensts)

s.push(element: 11)
address(of: &s.elemensts)

s.push(element: 12)
address(of: &s.elemensts)

print(s.elemensts)

class AClass {
    

}

var a = AClass()
address(of: &a)

address(of: &s)
