//
//  OnBoardingView.swift
//  Mac_Health
//
//  Created by 정회승 on 11/8/23.
//

import SwiftUI

struct OnBoardingView: View {
    var body: some View {
        ZStack{
            Color.gray_900.ignoresSafeArea()
            VStack{
                //tabBar
                TabView {
                    ForEach(1...3, id: \.self) { _ in
                        HStack{
                            Rectangle()
                                .foregroundColor(.green_main)
                        }
                    }
                    .frame(width:UIScreen.getWidth(390), height: UIScreen.getHeight(500))
                    .tabViewStyle(.page)
                }
                Button{
                    
                } label: {
                    appleLoginButton()
                }
                Button{
                    
                } label: {
                    aroundButton()
                }
                Spacer()
                    .frame(height: UIScreen.getHeight(20))
                
            }
            
        }
    }
    
    func appleLoginButton() -> some View {
        FloatingButton(backgroundColor: .white) {
            HStack{
                Image(systemName: "apple.logo")
                    .font(.button1())
                    .foregroundColor(.black)
                Text("Apple로 로그인")
                    .foregroundColor(.black)
            }
        }
    }
    
    func aroundButton() -> some View {
        FloatingButton(backgroundColor: .gray_600) { Text("둘러보기")
                .foregroundColor(.green_main)
                .font(.button1())
        }
    }
}

#Preview {
    OnBoardingView()
}
