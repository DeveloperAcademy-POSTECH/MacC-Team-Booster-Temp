//
//  SearchView.swift
//  Mac_Health
//
//  Created by 정회승 on 2023/10/20.
//

import SwiftUI

struct SearchView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.gray_900.ignoresSafeArea()
                
                ScrollView {
                    TopImage()
                    RecomendCardScroll
                    
                }
            }.ignoresSafeArea(.all)
        }
    }

    
    @ViewBuilder
    var RecomendCardScroll: some View {
            VStack(spacing: 20){
                HStack {
                    Text("전문가들의 일상 루틴")
                        .foregroundColor(.label_900)
                        .font(.title2())
                        .padding(.leading, 20)
                    Spacer()
                }.frame(maxWidth: .infinity)
                VStack(spacing: 20){
                    ForEach(1...5, id: \.self) {idx in
                        InfluencerCard()
                    }
                }
                
            }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
