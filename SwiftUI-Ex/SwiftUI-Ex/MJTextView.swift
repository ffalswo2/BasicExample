//
//  MJTextView.swift
//  SwiftUI-Ex
//
//  Created by 김민재 on 1/18/24.
//

import SwiftUI

struct MJTextView: View {
    var body: some View {
        Text("Hello, World!\nminjae hello world")
            .font(.title)
//            .baselineOffset(40) // 행간 간격
            .kerning(10) // 글자간 간격
            .multilineTextAlignment(.center)
            .foregroundStyle(.blue)
            .frame(width: 200, height: 100, alignment: .center)
            .minimumScaleFactor(0.1) // 10% 크기로 scale down
            
    }
}

#Preview {
    MJTextView()
}
