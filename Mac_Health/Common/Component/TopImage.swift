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
    
    var body: some View {
        TabView {
            ForEach(1...3, id: \.self) { idx in
                //둘러보기에서 구독 뷰
                NavigationLink {
                    SubscribeView()
                        .navigationBarTitle("정회승의 Smart Routine", displayMode: .inline)
                } label: {
                    RecommendPage()
                }
            }
        }
        .frame(height: UIScreen.getHeight(358))
        .tabViewStyle(.page)
    }
}


struct TopImageView_Previews: PreviewProvider {
    static var previews: some View {
        TopImage()
    }
}
