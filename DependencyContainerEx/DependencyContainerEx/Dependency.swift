//
//  Dependency.swift
//  DependencyContainerEx
//
//  Created by 김민재 on 2023/09/11.
//

import Foundation

public protocol DependencyProtocol: AnyObject {}

@propertyWrapper
public class Dependency<T: DependencyProtocol> {

    public var wrappedValue: T

    public init() {
        self.wrappedValue = DependencyContainer.resolve()
    }
}

class AccountManager: DependencyProtocol {

}


class Abc {
    @Dependency var accountManager: AccountManager
}

/*
 <일어나는 일>
 1. generic parameter T가 AccountManager로 대체된다.
 2. wrappedValue의 타입도 당연히 AccountManager.
 3. 어떠한 default value없이 property wrapper가 생성되었으므로 init() 생성자가 호출된다.
 4. resolve 메서드 호출.
 5. 이 때 resolve 메서드는 generic을 받는 메서드이지만, wrappedValue가 위에서 AccountManager라는 것이 이미 정해졌기 때문에 resolve메서드의 리턴타입 T가 AccountManager라는 것을 추론 가능하다.
    그렇기 때문에 resolve() 이렇게 간단하고 쓸 수 있는 것이다.
 6. resolve메서드를 통해서 이제 Object(dependency)를 리턴받으면 wrappedValue에 넣어준다.
 7.
 */


// wrappedValue가 객체를 strong하게 잡고 있기 때문에 그걸 해결하기 위해서
// protocol을 만들고 protocol타입으로 받게끔 하면 weakly하게 바꿀 수 있다.
// 이렇게하면 모든 Dependency는 해당 프로토콜을 채택해야한다.
