//
//  ColorsView.swift
//  SwiftUI-Ex
//
//  Created by 김민재 on 1/18/24.
//

import SwiftUI

struct ColorsView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
//            .fill(.red)
            .fill(Color("CustomColor"))
            .frame(width: 300, height: 200)
//            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            .shadow(color: Color("CustomColor").opacity(0.3), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: -20, y: -20)
    }
}

#Preview {
    ColorsView()
}
