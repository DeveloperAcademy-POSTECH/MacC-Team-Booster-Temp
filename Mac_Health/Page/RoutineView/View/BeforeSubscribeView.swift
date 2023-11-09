//
//  BeforeSubscribeView.swift
//  Mac_Health
//
//  Created by 정회승 on 11/9/23.
//

import SwiftUI

struct BeforeSubscribeView: View {
    var body: some View {
        //구독 X
        ZStack{
            Color.gray_900.ignoresSafeArea()
            VStack{
                Image("appTitle")
                    .resizable()
                    .scaledToFit()
                    .padding(.bottom, 20)
                Spacer()
                VStack{
                    Text("인플루언서의 운동일지를")
                    Text("구독하고 따라해보세요.")
                }
                .font(.title2())
                .foregroundColor(.label_900)
                .padding()
                NavigationLink{
                    SearchView()
                } label: {
                    RoundedRectangle(cornerRadius: 100)
                        .frame(width: UIScreen.getWidth(180), height: UIScreen.getHeight(60))
                        .foregroundColor(.green_main)
                        .overlay {
                           Text("둘러보기")
                                .font(.button1())
                                .foregroundColor(.gray_900)
                        }
                }
                Spacer()
            }
        }
    }
}

#Preview {
    NavigationStack{
        BeforeSubscribeView()
    }
}
