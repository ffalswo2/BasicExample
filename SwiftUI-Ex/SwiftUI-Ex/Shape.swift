//
//  Shape.swift
//  SwiftUI-Ex
//
//  Created by 김민재 on 1/18/24.
//

import SwiftUI

struct Shape: View {
    var body: some View {
//        Circle()
        //Ellipse()
//        Capsule(style: .continuous)
//        Rectangle()
        RoundedRectangle(cornerRadius: 40)
            .frame(width: 300, height: 200)
//            .fill(.green)
//            .stroke(.orange, style: StrokeStyle(lineWidth: 20, lineCap: .butt, dash: [10]))
//            .trim(from: 0.2, to: 1)
//            .stroke(.purple, lineWidth: 10)
        
            
    }
}

#Preview {
    Shape()
}
