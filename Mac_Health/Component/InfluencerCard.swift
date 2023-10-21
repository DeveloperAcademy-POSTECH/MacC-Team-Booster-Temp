//
//  InfluencerCard.swift
//  Mac_Health
//
//  Created by 정회승 on 2023/10/21.
//

import SwiftUI

struct InfluencerCard: View {
    
    var routineTitle = "최진혁의 Special Tip"
    var history = "피지크 PRO🏆"
    var influencerImage = "Influencer2"
    var backgroundImage = "Background2"
    
    var body: some View {
        
        ZStack{
            Rectangle()
                .foregroundColor(.gray_700)
            HStack{
                VStack(alignment: .leading){
                    Text(routineTitle)
                        .font(.headline1())
                        .foregroundColor(.lable_900)
                        .padding(.leading, 20)
                        .padding(.top, 24)
                    
                    Spacer()
                    Text(history)
                        .font(.headline2())
                        .foregroundColor(.lable_700)
                        .padding(.leading, 20)
                        .padding(.bottom, 24)
                }
                .frame(height: UIScreen.getHeight(156))
                Spacer()
                ZStack{
                    HStack{
                        Spacer()
                        Image(backgroundImage)
                            .resizable()
                            .scaledToFit()
                    }
                    Image(influencerImage)
                        .resizable()
                        .scaledToFill()
                        .frame(height: UIScreen.getHeight(156))
                        .padding(.top, 20)
                        .padding(.trailing, 20)
                }
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
        InfluencerCard()
    }
}
