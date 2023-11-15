//
//  InfluencerPreviewView.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/15/23.
//

import SwiftUI

/// 구독한 인플루언서가 없을 때 보여지는 뷰
///  - Parameters:
///   - maivVM: 탭 전환 함수 호출을 위한 메인 뷰 모델
struct InfluencerPreviewView: View {
    @EnvironmentObject var mainVM: MainViewModel
    
    var body: some View {
        ZStack {
            Color.gray_900.ignoresSafeArea()
            VStack {
                Image("appTitle")
                    .resizable()
                    .scaledToFit()
                    .padding(.bottom, 20)
                Spacer()
                VStack {
                    Text("인플루언서의 운동일지를\n구독하고 따라해보세요.")
                }
                .font(.title2())
                .foregroundColor(.label_900)
                .padding()
                Button {
                    mainVM.changeToSearchTab()
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
    InfluencerPreviewView()
}
