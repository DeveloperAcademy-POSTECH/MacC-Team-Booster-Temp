//
//  SingleInfluencerPreviewView.swift
//  beFLE
//
//  Created by 송재훈 on 11/18/23.
//

import SwiftUI

struct SingleInfluencerPreviewView: View {
    @Binding var influencer: InfluencerPreview
    @State private var showMailView = false
    @StateObject var vm = SingleInfluencerPreviewViewModel()
    
    var body: some View {
        ZStack {
            Color.gray_900.ignoresSafeArea()
            VStack {
                NavigationTitle
                NavigationLink {
                    SubscribeView(influencerId: influencer.influencerId)
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
                    MailView(data: $vm.mailData) { _ in }
                }
                Spacer()
            }
        }
    }
    
    var NavigationTitle: some View {
        HStack {
            Text("둘러보기")
                .font(.title2())
                .foregroundColor(.label_900)
                .padding(.leading, 3)
            Spacer()
        }
        .padding()
    }
    
    var SearchCard: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8.0)
                .foregroundColor(.gray_700)
                .frame(width: UIScreen.getWidth(350))
                .overlay {
                    AsyncImage(url: URL(string: influencer.singleExploreImageUrl)) { image in
                        HStack {
                            Spacer()
                            image
                                .resizable()
                                .scaledToFit()
                        }
                    } placeholder: {
                        LottieView()
                            .frame(width: 50, height: 50)
                    }
                    .frame(width: UIScreen.getWidth(350))
                }
                .clipped()
            
            HStack {
                VStack(alignment: .leading) {
                    Spacer()
                    Text("\(influencer.name)의 \(influencer.routineName)")
                        .font(.title1())
                        .foregroundColor(.label_900)
                        .padding(.bottom, 3)
                        .multilineTextAlignment(.leading)
                    Text(influencer.title)
                        .font(.body2())
                        .foregroundColor(.label_600)
                        .padding(.bottom, 12)
                }
                .padding(.leading, 3)
                Spacer()
            }
            .padding()
        }
        .padding(.top)
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
            .overlay {
                HStack {
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
            .padding(.top, 5)
    }
}

#Preview {
    SingleInfluencerPreviewView(influencer: .constant(InfluencerPreview(influencerId: 0, singleExploreImageUrl: "", multiExploreImageUrl: "", name: "", routineName: "", title: "")))
}
