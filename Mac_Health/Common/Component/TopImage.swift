//
//  TopImageView.swift
//  Mac_Health
//
//  Created by 정회승 on 2023/10/21.
//

import SwiftUI

struct TopImage: View {
    
    //    @StateObject private var searchVM = SearchVM()
    //    var recommend: RecommendInfluencer?
    @Binding var tabSelection: Int
    var body: some View {
        TabView {
            ForEach(1...3, id: \.self) { idx in
                //둘러보기에서 구독 뷰
                NavigationLink {
                    SubscribeView(tabSelection: $tabSelection)
                        .navigationBarTitle("정회승의 Smart Routine", displayMode: .inline)
                } label: {
                    RecommendPage(RecommendBannerNum: idx)
                }
            }
        }
        .overlay {
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
        .tabViewStyle(.page)
    }
    
}

struct RecommendPage: View {
    
    var RecommendBannerNum: Int
    
    var body: some View {
        
        ZStack(alignment: .bottomTrailing){
            Color.gray_900.ignoresSafeArea()
            
            Image("RecommendBanner\(RecommendBannerNum)")
                .resizable()
                .frame(width: UIScreen.getWidth(390), height: UIScreen.getHeight(358))
            
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
        }
        .frame(height: UIScreen.getHeight(358))
    }
}



struct TopImageView_Previews: PreviewProvider {
    static var previews: some View {
        TopImage(tabSelection: .constant(1))
    }
}
