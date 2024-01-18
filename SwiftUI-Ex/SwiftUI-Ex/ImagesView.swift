//
//  ImagesView.swift
//  SwiftUI-Ex
//
//  Created by 김민재 on 1/18/24.
//

import SwiftUI

struct ImagesView: View {
    var body: some View {
        Image("google")
//            .renderingMode(.template)
            .resizable()
            .scaledToFit()
            .frame(width: 300, height: 200)
            .foregroundStyle(.red)
//            .clipShape(
//                RoundedRectangle(cornerRadius: 25)
//            )
            
            
    }
}

#Preview {
    ImagesView()
}
