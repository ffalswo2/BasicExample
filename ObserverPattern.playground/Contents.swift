import Foundation

protocol Observer: AnyObject {
    func update()
}

class ConcreteObserverA: Observer {
    func update() {
        print("ConcreteObserverA Subject 변경 감지")
    }
}

class ConcreteObserverB: Observer {
    func update() {
        print("ConcreteObserverB Subject 변경 감지")
    }
}


struct Subject {
    var observers: [Observer] = []

    var state: Int = {
        return Int.random(in: 0...10)
    }()

    mutating func registerObserver(observer: Observer) {
        print("Subject에 Observer 등록 !")
        observers.append(observer)
    }

    mutating func unregisterObserver(observer: Observer) {
        print("Subject에 Observer 해제...")
        observers = observers.filter { $0 !== observer }
    }

    mutating func notifyObservers() {
        print("Subject -> Observers 알림 보내기")
        observers.forEach {
            $0.update()
        }
    }

    mutating func businessLogic() {
        print("Subject: I am doing something important")
        state = Int.random(in: 0...10)
        print("Subject: state가 변경되었습니다 to \(state)")
        notifyObservers()
    }
}

var subject = Subject()

let observer1 = ConcreteObserverA()
let observer2 = ConcreteObserverB()

// Observer 등록하기
subject.registerObserver(observer: observer1)
subject.registerObserver(observer: observer2)

// Business logic 수행 -> subject가 알림을 보내게 될 것 !
subject.businessLogic()

subject.unregisterObserver(observer: observer1)

subject.businessLogic()
