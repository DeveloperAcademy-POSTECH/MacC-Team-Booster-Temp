//
//  SingleInfluencerPreviewView.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/18/23.
//

import SwiftUI

struct SingleInfluencerPreviewView: View {
    @Binding var influencer: InfluencerPreview
    
    @StateObject var vm = SingleInfluencerPreviewViewModel()
    
    var body: some View {
        ZStack {
            Color.gray_900.ignoresSafeArea()
            VStack {
                NavigationTitle
                NavigationLink {
                    //                    SubscribeView(tabSelection: $tabSelection, subscribed: $subscribed)
                } label: {
                    SearchCard
                }
                
                Button {
                    vm.showMailView = true
                } label: {
                    InquiryCard
                }
                .disabled(!MailView.canSendMail)
                .sheet(isPresented: $vm.showMailView) {
                    MailView(data: $vm.mailData) { result in
                        print(result)
                    }
                }
                Spacer()
                //                        .frame(height: UITabBarController().height)
            }
            .padding(.bottom, 35)
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
    
    var SearchCard: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8.0)
                .foregroundColor(.gray_700)
                .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(400))
            
            // TODO: api 작업 후 수정
            AsyncImage(url: URL(string: influencer.onePersonProfileImageUrl ?? "")) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                Image(systemName: "arrow.triangle.2.circlepath")
                    .resizable()
                    .scaledToFit()
                    .padding(50)
            }
                
            HStack {
                VStack(alignment: .leading) {
                    Spacer()
                    Text("\(influencer.name)의 \(influencer.routineName)")
                        .font(.title1())
                        .foregroundColor(.label_900)
                    Text(influencer.title)
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

#Preview {
    SingleInfluencerPreviewView(influencer: .constant(InfluencerPreview(influencerId: 1, name: "", routineName: "", title: "")))
}
