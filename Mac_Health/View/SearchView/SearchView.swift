//
//  SearchView.swift
//  Mac_Health
//
//  Created by 정회승 on 2023/10/20.
//

import SwiftUI

struct SearchView: View {
    var body: some View {
        //네비게이션 스택
            ZStack {
                Color.gray_900.ignoresSafeArea()
                    VStack {
                        ScrollView {
                        TopImage()
                        RecomendCardScroll
                    }
                        .padding(.bottom, 35)
                    Spacer()
                        .frame(height: UITabBarController().height)
                }
                .ignoresSafeArea()
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
                }
                VStack(spacing: 20){
                    ForEach(1..<4, id: \.self) {idx in
                        //전문가들의 일상 루틴에서 구독 뷰
                        NavigationLink {
                            SubscribeView()
                                .navigationBarTitle("정회승의 Smart Routine", displayMode: .inline)
                        } label: {
                            InfluencerCard(cardBannerNum: idx)
                        }
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
