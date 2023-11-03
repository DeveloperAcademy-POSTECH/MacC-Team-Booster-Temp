//
//  TodayRoutineMultiView.swift
//  Mac_Health
//
//  Created by 정회승 on 11/2/23.
//

import SwiftUI

struct TodayRoutineMultiView: View {
    var body: some View {
        VStack{
            Image("appTitle")
                .resizable()
                .scaledToFit()
                .padding(.bottom, 20)
            ScrollView{
                ForEach(1..<4, id: \.self) {idx in
                    SubscribedInfluencerCard(cardBannerNum: idx)
                        .padding(.bottom, 10)
                }
            }
        }
    }
}

#Preview {
    TodayRoutineMultiView()
}
