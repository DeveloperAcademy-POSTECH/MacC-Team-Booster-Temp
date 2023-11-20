//
//  MockUpSearchView.swift
//  Mac_Health
//
//  Created by 정회승 on 11/15/23.
//

import SwiftUI

struct MockUpSearchView: View {
    @State private var mailData = ComposeMailData(subject: "비플 문의하기",
                                                  recipients: ["pmchung423@gmail.com"],
                                                  message: "비플 문의하기",
                                                  attachments: [
                                                    //                                                                                                        AttachmentData(data: "Some text".data(using: .utf8)!,
                                                    //                                                                                                                                   mimeType: "text/plain",
                                                    //                                                                                                                                   fileName: "text.txt")
                                                  ]
    )
    @State private var showMailView = false
    @Binding var tabSelection: Int
    var body: some View {
        
        //둘러보기 1인용
        ZStack {
            Color.gray_900.ignoresSafeArea()
            VStack {
                NavigationTitle
                NavigationLink {
                    MockUpSubscribeView(tabSelection: $tabSelection)
                } label: {
                    SearchCard
                }
                
                Button {
                    showMailView.toggle()
                } label: {
                    InquiryCard
                }
                .disabled(!MailView.canSendMail)
                .sheet(isPresented: $showMailView) {
                    MailView(data: $mailData) { result in
                        print(result)
                    }
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
            Image("searchviewImage")
                .resizable()
                .scaledToFit()
                .foregroundColor(.blue)
            HStack {
                VStack(alignment: .leading){
                    Spacer()
                    Text("정회승의 Smart Routine")
                        .font(.title1())
                        .foregroundColor(.label_900)
                        .padding(.bottom, 3)
                    Text("2022 Mr. 서울대🏆")
                        .font(.body2())
                        .foregroundColor(.label_600)
                        .padding(.bottom, 12)
                }
                .padding(.leading, 3)
                Spacer()
            }
            .padding()
        }
        .padding(.top, 10)
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
                        .padding(.leading, 4)
                    Spacer()
                    Text("문의")
                        .foregroundColor(.label_700)
                        .font(.button2())
                        .padding(.trailing, 5)
                }
                .padding()
            }
            .padding(.top, 5)
    }
    
//    @ViewBuilder
//    var RecommendCardScroll: some View {
//        VStack(spacing: 20){
//            HStack {
//                Text("전문가들의 일상 루틴")
//                    .foregroundColor(.label_900)
//                    .font(.title2())
//                    .padding(.leading, 20)
//                Spacer()
//            }
//            VStack(spacing: 20){
//                ForEach(1..<4, id: \.self) {idx in
//                    //전문가들의 일상 루틴에서 구독 뷰
//                    NavigationLink {
//                        MockUpSubscribeView(tabSelection: $tabSelection)
//                            .navigationBarTitle("정회승의 Smart Routine", displayMode: .inline)
//                    } label: {
//                        InfluencerCard(cardBannerNum: idx)
//                    }
//                }
//            }
//        }
//    }
}

#Preview {
    MockUpSearchView(tabSelection: .constant(1))
}
