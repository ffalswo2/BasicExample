//
//  SpacerView.swift
//  SwiftUI-Ex
//
//  Created by 김민재 on 1/21/24.
//

import SwiftUI

struct SpacerView: View {
    var body: some View {
        VStack {
            HStack(spacing: 0, content: {
                Image(systemName: "xmark")
                Spacer()
                    .frame(height: 10)
                    .background(.orange)
                Image(systemName: "gear")
            })
            .font(.title)
            .padding(.horizontal)
            
            
            Spacer()
                .frame(width: 10)
                .background(.orange)
        }
        .background(.green)
    }
}

#Preview {
    SpacerView()
}
