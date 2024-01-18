//
//  GradientsView.swift
//  SwiftUI-Ex
//
//  Created by 김민재 on 1/18/24.
//

import SwiftUI

struct GradientsView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(
//                LinearGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing)
//                RadialGradient(gradient: Gradient(colors: [.red, .blue]), center: .topLeading, startRadius: 5, endRadius: 500) // 작은 원부터 큰원
//                AngularGradient(gradient: Gradient(colors: [Color.red, Color.blue]), center: .center, angle: .degrees(90))
            )
            .frame(width: 300, height: 200)
    }
}

#Preview {
    GradientsView()
}
