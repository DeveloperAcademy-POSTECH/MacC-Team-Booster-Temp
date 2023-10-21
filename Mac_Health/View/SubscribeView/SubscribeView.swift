//
//  SubscribeView.swift
//  Mac_Health
//
//  Created by 정회승 on 2023/10/21.
//

import SwiftUI

struct SubscribeView: View {
    
    @State var seeMore:Bool = false
    var introduce = "한국인 최초로 북미에서 열리는 프로쇼 우승 (텍사스 프로, 2023.8.18)"
    var award = """
- 2023년 TEXAS PRO SHOW MEN'S CLASSIC PHYSIQUE 1위
- 2022년 MR.Olympia 클래식 피지크 15위
- 2022년 MONSTERZYM CLASSIC PHYSIQUE PRO 1위
- 2021년 AGP CLASSIC PHYSIQUE PRO 4위
- 2020년 아마추어 올림피아 부산 CLASSIC PHYSIQUE CLASS B 1위
"""
    
    var body: some View {
        ZStack {
            Color.gray_900.ignoresSafeArea()
            
            ScrollView {
                //구독 페이지 설명
                RecommendPage()
                //구독 버튼
                subscribeButton
                //인플루언서 설명
                if seeMore == false {
                    ZStack(alignment: .bottom){
                        VStack(alignment: .leading){
                            Text("소개")
                                .foregroundColor(.label_900)
                                .font(.headline1())
                            Text(introduce)
                                .foregroundColor(.label_800)
                                .font(.body)
                                .padding(.bottom, 20)
                            Text("수상경력")
                                .foregroundColor(.label_900)
                                .font(.headline1())
                            Text(award)
                                .foregroundColor(.label_800)
                                .font(.body)
                                .padding(.bottom, 20)
                                .padding(.leading, 5)
                        }
                        Image("seeMoreGradient")
                            .resizable()
                            .scaledToFit()
                            
                        Button {
                            seeMore = true
                        } label: {
                            Text("더보기")
                                .font(.headline1())
                                .foregroundColor(Color.label_900)
                        }
                        .offset(y: 10)
                        
                    }
                    .frame(width: UIScreen.getWidth(384), height: UIScreen.getHeight(260))
                    .padding()
                }
                else {
                                    VStack(alignment: .leading){
                                        Text("소개")
                                            .foregroundColor(.label_900)
                                            .font(.headline1())
                                        Text(introduce)
                                            .foregroundColor(.label_800)
                                            .font(.body)
                                            .padding(.bottom, 20)
                                        Text("수상경력")
                                            .foregroundColor(.label_900)
                                            .font(.headline1())
                                        Text(award)
                                            .foregroundColor(.label_800)
                                            .font(.body)
                                            .padding(.bottom, 20)
                                            .padding(.leading, 5)
                                    }
                                    .padding()
                }
                
                //루틴 미리보기
            

                
                
            }
        }.ignoresSafeArea(.all)

    }
    
    var subscribeButton: some View {
        Button {
            
        } label: {
            RoundedRectangle(cornerRadius: 100)
                .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(60))
                .foregroundColor(Color.green_main)
                .overlay{
                    Text("구독하기")
                        .foregroundColor(Color.gray_900)
                        .font(.button1())
                }
        }
    }
}

struct SubscribeView_Previews: PreviewProvider {
    static var previews: some View {
        SubscribeView()
    }
}
