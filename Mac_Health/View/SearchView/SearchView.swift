//
//  SearchView.swift
//  Mac_Health
//
//  Created by 정회승 on 2023/10/20.
//

import SwiftUI

struct SearchView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                TopImage
            }
            }
    }
    @ViewBuilder
    var TopImage: some View {
        HStack {
            Text("둘러보기")
                .foregroundColor(.lable_900)
                .font(.title2())
                .padding(20)
            Spacer()
        }.frame(maxWidth: .infinity)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
