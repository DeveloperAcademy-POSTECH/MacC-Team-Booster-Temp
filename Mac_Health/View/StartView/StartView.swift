//
//  StartView.swift
//  Mac_Health
//
//  Created by 정회승 on 2023/11/01.
//

import SwiftUI

struct StartView: View {
    var body: some View {
        VStack{
            Image("appTitle")
                .resizable()
                .scaledToFit()
                .padding(.bottom, 20)
            ScrollView{
                ForEach(1..<4, id: \.self) {idx in
                    SubscribedInfluencerCard(cardBannerNum: idx)
                        .padding(.bottom, 20)
                }
            }
        }
    }
    
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
