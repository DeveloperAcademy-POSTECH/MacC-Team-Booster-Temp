//
//  InfluencerCard.swift
//  beFLE
//
//  Created by 정회승 on 2023/10/21.
//

import SwiftUI

struct InfluencerCard: View {
    var routineTitle = "최진혁의 Special Tip"
    var history = "피지크 PRO🏆"
    var cardBannerNum: Int
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.gray_700)
            HStack {
                VStack(alignment: .leading) {
                    Text(routineTitle)
                        .font(.headline1())
                        .foregroundColor(.label_900)
                        .padding(.leading, 20)
                        .padding(.top, 24)
                    
                    Spacer()
                    Text(history)
                        .font(.headline2())
                        .foregroundColor(.label_700)
                        .padding(.leading, 20)
                        .padding(.bottom, 24)
                }
                .frame(height: UIScreen.getHeight(156))
                Spacer()
                Image("CardBanner\(cardBannerNum)")
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

struct InfluencerCard_Previews: PreviewProvider {
    static var previews: some View {
        InfluencerCard(cardBannerNum: 1)
    }
}
