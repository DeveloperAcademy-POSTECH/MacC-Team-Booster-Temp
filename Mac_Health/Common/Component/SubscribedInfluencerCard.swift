//
//  SubscribedInfluencerCard.swift
//  Mac_Health
//
//  Created by 정회승 on 2023/11/01.
//

import SwiftUI

struct SubscribedInfluencerCard: View {
    var influencerTitle = "정회승의 Smart Routine"
    var todayPart = "등, 이두"
    var setCount = "6개"
    var cardBannerNum: Int
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(.gray_700)
            HStack{
                VStack(alignment: .leading){
                    Text(influencerTitle)
                        .font(.headline1())
                        .foregroundColor(.label_900)
                        .padding(.leading, 20)
                        .padding(.top, 24)
                    
                    Spacer()
                    HStack{
                        Text(todayPart)
                            .font(.headline2())
                            .foregroundColor(.label_700)
                            .padding(.leading, 20)
                            .padding(.bottom, 24)
                        Text("|")
                            .font(.headline2())
                            .foregroundColor(.label_700)
                            .padding(.bottom, 24)
                        Text(setCount)
                            .font(.headline2())
                            .foregroundColor(.label_700)
                            .padding(.bottom, 24)
                    }
                }
                .frame(height: UIScreen.getHeight(156))
                Spacer()
                Image("CardBanner\(cardBannerNum)")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.getWidth(156))
            }
        }
        .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(156))
        .mask(
            RoundedRectangle(cornerRadius: 8)
                .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(156))
        )
    }
}

struct SubscribedInfluencerCard_Previews: PreviewProvider {
    static var previews: some View {
        SubscribedInfluencerCard(cardBannerNum: 1)
    }
}

