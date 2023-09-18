//
//  Weak.swift
//  DependencyContainerEx
//
//  Created by 김민재 on 2023/09/11.
//

import Foundation


class Weak: Equatable {
    weak var value: Any?

    init(value: Any) {
        self.value = value
    }

    static func == (lhs: Weak, rhs: Weak) -> Bool {
        return lhs.value === rhs.value
    }
}
