//
//  SearchView.swift
//  Mac_Health
//
//  Created by 정회승 on 2023/10/20.
//

import SwiftUI

struct SearchView: View {
    @StateObject var vm = SearchViewModel()
    @State private var mailData = ComposeMailData(subject: "비플 문의하기",
                                                  recipients: ["pmchung423@gmail.com"],
                                                  message: "비플 문의하기",
                                                  attachments: [
                                                    //                                                    AttachmentData(data: "Some text".data(using: .utf8)!,
                                                    //                                                                               mimeType: "text/plain",
                                                    //                                                                               fileName: "text.txt")
                                                  ]
    )
    @State private var showMailView = false
    @Binding var subscribed: Bool
    @Binding var tabSelection: Int
    
    var body: some View {
        ZStack {
            
        }
        .onAppear {
            vm.fetchInfluencer()
        }
    }
    
    var SearchCard: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 8.0)
                .foregroundColor(.gray_700)
                .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(400))
            Image("Influencer1")
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
    
    //    @ViewBuilder
    //    var RecommendCardScroll: some View {
    //            VStack(spacing: 20){
    //                HStack {
    //                    Text("전문가들의 일상 루틴")
    //                        .foregroundColor(.label_900)
    //                        .font(.title2())
    //                        .padding(.leading, 20)
    //                    Spacer()
    //                }
    //                VStack(spacing: 20){
    //                    ForEach(1..<4, id: \.self) {idx in
    //                        //전문가들의 일상 루틴에서 구독 뷰
    //                        NavigationLink {
    //                            SubscribeView(tabSelection: $tabSelection, subscribed: $subscribed)
    //                        } label: {
    //                            InfluencerCard(cardBannerNum: idx)
    //                        }
    //                    }
    //                }
    //            }
    //    }
}

//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView()
//    }
//}
