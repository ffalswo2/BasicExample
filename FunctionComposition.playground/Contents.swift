import UIKit

let result = [1,2,3]
    .map { $0 + 1 }
    .map { "만 \($0)세" }
print(result)

let num: Int? = nil
let result2 = num.map { $0 + 1 }
print(result2)

let num2: Int? = 1
let result3 = num2.map { $0 + 1 }
print(result3)

let myResult: Result<Int, Error> = .success(2)
let result4 = myResult.map { $0 + 1 }
print(result4)


let ageString: String? = "10"
let str = ageString.map { Int($0) }
str // Int??

if let x = ageString.map(Int.init),
   let y = x {
    print(y)
}

if case let .some(.some(x)) = ageString.map(Int.init) {
    print(x)
}

if case let x?? = ageString.map(Int.init) {
    print(x)
}

let intStr = ageString.flatMap(Int.init)
print(intStr) // Optional(10)

struct MyModel: Decodable {
    let name: String
}

let myLabel = UILabel()

if let data = UserDefaults.standard.data(forKey: "my_data_key") {
    if let model = try? JSONDecoder().decode(MyModel.self, from: data) {
        let welcomeMessage = "Hello \(model.name)"
        myLabel.text = welcomeMessage
    }
}

let welcomeMsg = UserDefaults.standard.data(forKey: "my_data_key")
    .flatMap { try? JSONDecoder().decode(MyModel.self, from: $0)
    }
    .map(\.name)
    .map { "Hello \($0)" }

myLabel.text = welcomeMsg
