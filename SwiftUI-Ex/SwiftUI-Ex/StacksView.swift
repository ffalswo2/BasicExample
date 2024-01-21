//
//  StacksView.swift
//  SwiftUI-Ex
//
//  Created by 김민재 on 1/21/24.
//

import SwiftUI

struct StacksView: View {
    // VStacks => Vertical
    // HStacks => Horizontal
    // ZStacks => zIndex (back to front)
    var body: some View {
        VStack(spacing: 50, content: {
            
            ZStack(content: {
                Circle()
                    .frame(width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                
                Text("1")
                    .font(.title)
                    .foregroundStyle(.white)
            })
            // 위랑 아래랑 완전히 동일하게 생김.
            
            // 뒤에나 앞에 딱 1개~2,3개 layer만큼정도만 더 있으면
            // 주로 overlay나 background를 많이 사용함.
            // 근데 요소가 많다? 그럼 ZStack 활용.
            
            // 보여지는 결과가 완전히 동일하기 때문에 사실 정답은 없다!
            // => ZStack이 조금 더 직관적으로 이해가 잘되는 거는 사실인듯?
            Text("1")
                .font(.title)
                .foregroundStyle(.white)
                .background(
                    Circle()
                        .frame(width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                )
        })
//        VStack(alignment: .center, spacing: 20, content: {
//            Text("5")
//                .font(.largeTitle)
//                .underline()
//            
//            Text("Items in your cart:")
//                .font(.caption)
//                .foregroundStyle(.gray)
//            
//        })
//        ZStack(alignment: .bottom, content: {
//            Rectangle()
//                .fill(.yellow)
//                .frame(width: 350, height: 500, alignment: .center)
//            
//            VStack(alignment: .leading, spacing: 30, content: {
//                Rectangle()
//                    .fill(.red)
//                    .frame(width: 150, height: 150)
//                
//                Rectangle()
//                    .fill(.green)
//                    .frame(width: 100, height: 100)
//                
//                HStack(alignment: .bottom, spacing: 30, content: {
//                    Rectangle()
//                        .fill(.purple)
//                        .frame(width: 50, height: 50)
//                    
//                    Rectangle()
//                        .fill(.pink)
//                        .frame(width: 50, height: 50)
//                    
//                    Rectangle()
//                        .fill(.pink)
//                        .frame(width: 25, height: 25)
//                })
//                .background(.white)
//                
//            })
//            .background(.blue)
//            
//        })
//        VStack(alignment: .trailing, spacing: 0,
//               content: {
//            Rectangle()
//                .fill(.red)
//                .frame(width: 200, height: 200)
//            
//            Rectangle()
//                .fill(.green)
//                .frame(width: 150, height: 150)
//            
//            Rectangle()
//                .fill(.orange)
//                .frame(width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
//        })
//        VStack(content: {
//            Rectangle()
//                .fill(.red)
//                .frame(width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
//            
//            Rectangle()
//                .fill(.green)
//                .frame(width: 100, height: 100)
//            
//            Rectangle()
//                .fill(.orange)
//                .frame(width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
//            
//        })
    }
}

#Preview {
    StacksView()
}
