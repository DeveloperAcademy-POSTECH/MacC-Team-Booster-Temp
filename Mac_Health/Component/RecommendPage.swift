//
//  RecomendPage.swift
//  Mac_Health
//
//  Created by 정회승 on 2023/10/21.
//

import SwiftUI

struct RecommendPage: View {
    
    var recommendImage = "Influencer1"
    var recommendBG = "Background1"
    
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            Color.black.ignoresSafeArea()
            HStack{
                Spacer()
                Image(recommendBG)
                    .resizable()
                    .scaledToFit()
            }
            Image(recommendImage)
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.getWidth(350))
                .clipped()
                
            Image("gradient")
                .resizable()
                .frame(width: UIScreen.screenWidth, height: UIScreen.screenWidth*0.9)
            
            HStack{
                VStack(alignment: .leading, spacing: 16){
                    Text("정회승의 Smart Routine")
                        .foregroundColor(.label_900)
                        .font(.title1())
                    Text("2022 Mr. 서울대🏆")
                        .foregroundColor(.label_600)
                        .font(.body2())
                        .padding(.bottom, 40)
                }
                Spacer()
            }
            .padding(.leading, 20)
        }
        .frame(width: UIScreen.screenWidth, height: UIScreen.screenWidth*0.9)
    }
}

struct RecomendPage_Previews: PreviewProvider {
    static var previews: some View {
        RecommendPage()
    }
}
