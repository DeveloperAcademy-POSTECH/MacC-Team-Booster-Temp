//
//  MockUpSearchView.swift
//  beFLE
//
//  Created by 정회승 on 11/15/23.
//

import SwiftUI

struct MockUpSearchView: View {
    @State private var mailData = ComposeMailData(subject: "비플 문의하기", recipients: ["pmchung423@gmail.com"], message: "비플 문의하기", attachments: [])
    @State private var showMailView = false
    
    var body: some View {
        ZStack {
            Color.gray_900.ignoresSafeArea()
            VStack {
                NavigationTitle
                SearchCard
                InquiryCard
                    .disabled(!MailView.canSendMail)
                    .sheet(isPresented: $showMailView) {
                        MailView(data: $mailData) { _ in }
                    }
                Spacer()
            }
            .padding(.bottom, 35)
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
    
    @ViewBuilder
    var SearchCard: some View {
        NavigationLink {
            MockUpSubscribeView()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 8.0)
                    .foregroundColor(.gray_700)
                    .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(400))
                    .overlay {
                        HStack {
                            Spacer()
                            Image("searchviewImage")
                                .resizable()
                                .scaledToFill()
                        }
                    }
                
                HStack {
                    VStack(alignment: .leading) {
                        Spacer()
                        Text("정회승의 Smart Routine")
                            .font(.title1())
                            .foregroundColor(.label_900)
                            .padding(.bottom, 3)
                            .multilineTextAlignment(.leading)
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
        }
    }
    
    @ViewBuilder
    var InquiryCard: some View {
        Button {
            showMailView.toggle()
        } label: {
            RoundedRectangle(cornerRadius: 8.0)
                .frame(width: UIScreen.getWidth(350), height: UIScreen.getWidth(68))
                .foregroundColor(.fill_3)
                .overlay {
                    HStack {
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
    }
}
