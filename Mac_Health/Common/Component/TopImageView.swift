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
            ZStack(alignment: .topLeading){
                ScrollView(.horizontal){
                    HStack{
                        ForEach(1...3, id: \.self) { idx in
                            RecommendPage()
//                                .gesture(
//                                    DragGesture()
//                                        .onEnded({value in
//                                            let threshold: CGFloat = 30
//                                            if value.translation.width > threshold {
//                                                withAnimation{
//                                                    searchVM.currentIndex = max(0, searchVM.currentIndex - 1)
//                                                }
//                                            }else if value.translation.width < -threshold {
//                                                withAnimation{
//                                                    searchVM.currentIndex = min(3, searchVM.currentIndex + 1)
//                                                }
//                                            }
//                                                }
//                                        )
//                                    )
                        }
                    }
                }.scrollIndicators(.hidden)
                
                HStack{
                    Text("둘러보기")
                        .foregroundColor(.label_900)
                        .font(.title2())
                        .padding(20)
                        .padding(.top, 50)
                    Spacer()
                }
            }
    }
}
                                                 

struct TopImageView_Previews: PreviewProvider {
    static var previews: some View {
        TopImage()
    }
}
