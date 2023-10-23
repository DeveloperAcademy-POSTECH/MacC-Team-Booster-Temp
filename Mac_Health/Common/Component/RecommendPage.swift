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
            Color.gray_900.ignoresSafeArea()
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
                
            LinearGradient(colors: [.gray_900,.clear, .clear, .gray_900.opacity(0.7), .gray_900], startPoint: .top, endPoint: .bottom)
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
            VStack {
                HStack{
                    Text("둘러보기")
                        .foregroundColor(.label_900)
                        .font(.title2())
                        .padding(20)
                        .padding(.top, 50)
                    Spacer()
                }
                Spacer()
            }
        }
        .frame(height: UIScreen.getHeight(358))
    }
}

struct RecomendPage_Previews: PreviewProvider {
    static var previews: some View {
        RecommendPage()
    }
}
