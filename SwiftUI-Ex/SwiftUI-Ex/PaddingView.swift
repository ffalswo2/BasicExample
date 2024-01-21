//
//  PaddingView.swift
//  SwiftUI-Ex
//
//  Created by 김민재 on 1/21/24.
//

import SwiftUI

struct PaddingView: View {
    var body: some View {
        VStack(alignment: .leading, content: {
            Text("Hello, World !")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .padding(.bottom, 30)
            
            Text("This is the description of what we will do on this screen. It is multiple lines and we will align the text to the leading edge.")
                .baselineOffset(5)
                
        })
        .padding()
        .padding(.vertical, 10)
        .background(
            Color.white
                .clipShape(
                    RoundedRectangle(cornerRadius: 10)
                )
                .shadow(color: .black.opacity(0.3), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0, y: 10)
                
        )
        
        .padding(.horizontal, 10)
//        Text("Hello Mozzi, minjae")
//            .font(.largeTitle)
//            .fontWeight(.semibold)
//            .frame(maxWidth: .infinity, alignment: .leading)
//            .padding(.leading, 20)
    }
}

#Preview {
    PaddingView()
}
