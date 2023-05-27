//
//  RealmDTO.swift
//  SOPT32-Seminar-3
//
//  Created by 김민재 on 2023/05/27.
//

import Foundation

import Realm
import RealmSwift

struct PostDTO: Equatable {
    var id: Int
    var img: String = ""
    var name: String = ""
    var location: String = ""
    var date: String = ""
    var price: String = ""
    var status: String = ""
}

final class RealmStoragePost: Object {

    @Persisted(primaryKey: true) var id: Int

    @Persisted var img: String?
    @Persisted var name: String?
    @Persisted var location: String?
    @Persisted var date: String?
    @Persisted var price: String?
    @Persisted var status: String?

    override static func primaryKey() -> String? {
      return "RealmStoragePost"
    }

    convenience init(input: PostDTO) {
        self.init()
        self.id = input.id
        self.img = input.img
        self.name = input.name
        self.location = input.location
        self.date = input.date
        self.price = input.price
        self.status = input.status
    }
}

