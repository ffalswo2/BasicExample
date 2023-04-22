//
//  NSObject+.swift
//  SOPT32-Seminar-3
//
//  Created by 김민재 on 2023/04/22.
//

import Foundation


extension NSObject {
    static var className: String {
        return String(describing: self)
    }
}
