//
//  SearchView.swift
//  Mac_Health
//
//  Created by 정회승 on 2023/10/20.
//

import SwiftUI

struct SearchView: View {
    @Binding var tabSelection: Int
    var body: some View {
        //네비게이션 스택 2인 이상
//            ZStack {
//                Color.gray_900.ignoresSafeArea()
//                    VStack {
//                        ScrollView {
//                        TopImage()
//                        RecommendCardScroll
//                    }
//                        .padding(.bottom, 35)
//                    Spacer()
//                        .frame(height: UITabBarController().height)
//                }
//                .ignoresSafeArea()
//            }
        
        //둘러보기 1인용
        ZStack {
            Color.gray_900.ignoresSafeArea()
                VStack {
                    NavigationTitle
                    NavigationLink {
                        SubscribeView(tabSelection: $tabSelection)
                    } label: {
                        SearchCard
                    }

                    Button {
                        print("email modal")
                    } label: {
                        InquiryCard
                    }
                    Spacer()
//                        .frame(height: UITabBarController().height)
            }
                .padding(.bottom, 35)
//            .ignoresSafeArea()
        }
    }

    var NavigationTitle: some View {
        HStack {
            Text("둘러보기")
                .font(.title2())
                .foregroundColor(.label_900)
            Spacer()
        }
        .padding()
    }
    
    @ViewBuilder
    var SearchCard: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 8.0)
                .foregroundColor(.gray_700)
                .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(400))
            Image(systemName: "person.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(.blue)
            HStack {
                VStack(alignment: .leading){
                    Spacer()
                    Text("정회승의 Smart Routine")
                        .font(.title1())
                        .foregroundColor(.label_900)
                    Text("2022 Mr. 서울대🏆")
                        .font(.body2())
                        .foregroundColor(.label_600)
                        .padding(.bottom, 12)
                }
                Spacer()
            }
            .padding()
        }
        .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(400))
//        .mask(
//            RoundedRectangle(cornerRadius: 8.0)
//                .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(400))
//        )
    }
    
    @ViewBuilder
    var InquiryCard: some View {
        RoundedRectangle(cornerRadius: 8.0)
            .frame(width: UIScreen.getWidth(350), height: UIScreen.getWidth(68))
            .foregroundColor(.fill_3)
            .overlay{
                HStack{
                    Text("나도 운동일지를 공유하고 싶다면?")
                        .foregroundColor(.label_700)
                        .font(.body2())
                    Spacer()
                    Text("문의하기")
                        .foregroundColor(.label_700)
                        .font(.button2())
                }
                .padding()
            }
    }
    
    @ViewBuilder
    var RecommendCardScroll: some View {
            VStack(spacing: 20){
                HStack {
                    Text("전문가들의 일상 루틴")
                        .foregroundColor(.label_900)
                        .font(.title2())
                        .padding(.leading, 20)
                    Spacer()
                }
                VStack(spacing: 20){
                    ForEach(1..<4, id: \.self) {idx in
                        //전문가들의 일상 루틴에서 구독 뷰
                        NavigationLink {
                            SubscribeView(tabSelection: $tabSelection)
                                .navigationBarTitle("정회승의 Smart Routine", displayMode: .inline)
                        } label: {
                            InfluencerCard(cardBannerNum: idx)
                        }
                    }
                }
            }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(tabSelection: .constant(1))
    }
}
