//
//  FramesView.swift
//  SwiftUI-Ex
//
//  Created by 김민재 on 1/20/24.
//

import SwiftUI

struct FramesView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .background(.green)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.red)
    }
}

#Preview {
    FramesView()
}
