//
//  DependencyContainer.swift
//  DependencyContainerEx
//
//  Created by 김민재 on 2023/09/11.
//

import Foundation

public class DependencyContainer {

    private var dependencies = [String: Weak]()
    private let lock = NSLock()

    private static let shared = DependencyContainer()
    private init() {}

    public static func register<T>(_ dependency: T) {
        shared.lock.lock()
        shared.register(dependency)
        shared.lock.unlock()
    }

    public static func resolve<T>() -> T {
        shared.resolve()
    }

    private func register<T>(_ dependency: T) {
        let key = "\(type(of: T.self))"
        let weak = Weak(value: dependency as AnyObject)
        dependencies[key] = weak
    }

    private func resolve<T>() -> T {
        let key = "\(type(of: T.self))"
        let weak = dependencies[key]

        precondition(weak != nil, "No Dependency found for \(key), Application must register a dependency before resolving it.")

        let dependency = weak!.value as? T

        precondition(dependency != nil, "Dependency is already deallocated by the system.")

        return dependency!
    }
}
