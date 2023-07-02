//
//  Week.swift
//  ExpandCell
//
//  Created by 김민재 on 2023/07/01.
//

import Foundation


struct Curriculum {
    let week: Int
    let description: String
    let isDescHidden: Bool
}


extension Curriculum {
    static func dummy() -> [Curriculum] {
        return [
            Curriculum(week: 1, description: "sadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafad", isDescHidden: true),
            Curriculum(week: 2, description: "sadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafad", isDescHidden: true),
            Curriculum(week: 3, description: "sadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafad", isDescHidden: true),
            Curriculum(week: 4, description: "sadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafad", isDescHidden: true),
            Curriculum(week: 5, description: "sadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafad", isDescHidden: true),
            Curriculum(week: 6, description: "sadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafad", isDescHidden: true),
            Curriculum(week: 7, description: "sadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafad", isDescHidden: true),
            Curriculum(week: 8, description: "sadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafad", isDescHidden: true),
            Curriculum(week: 9, description: "sadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafad", isDescHidden: true),
            Curriculum(week: 10, description: "sadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafad", isDescHidden: true),
            Curriculum(week: 11, description: "sadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafad", isDescHidden: true),
            Curriculum(week: 12, description: "sadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafad", isDescHidden: true),
            Curriculum(week: 13, description: "sadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafad", isDescHidden: true),
            Curriculum(week: 14, description: "sadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafadsadfsadfsdafad", isDescHidden: true)
        ]
    }
}
