//
//  IconsView.swift
//  SwiftUI-Ex
//
//  Created by 김민재 on 1/18/24.
//

import SwiftUI

struct IconsView: View {
    var body: some View {
        Image(systemName: "person.fill.badge.plus")
            .renderingMode(.original)
            .font(.largeTitle)
//            .resizable()  resizeable해줘야 frame에 따라 바뀜.
//            .aspectRatio(contentMode: .fill)
//            .font(.largeTitle) // 이거 쓰는게 아이폰기기에 따라 dynamic하게 적용되어서 좋긴함.
//            .font(.system(size: 80))
//            .foregroundStyle(.red)
//            .frame(width: 300, height: 300) // frame만 쓰면 버튼 size안바뀜
//            .clipped()
    }
}

#Preview {
    IconsView()
}
