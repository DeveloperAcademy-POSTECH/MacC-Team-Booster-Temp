//
//  SingleInfluencerPreviewView.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/18/23.
//

import SwiftUI

struct SingleInfluencerPreviewView: View {
    var body: some View {
        ZStack {
            Color.gray_900.ignoresSafeArea()
            VStack {
                NavigationTitle
                NavigationLink {
                    SubscribeView(tabSelection: $tabSelection, subscribed: $subscribed)
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
}
    
#Preview {
    SingleInfluencerPreviewView()
}
