//
//  RecordingFinishView.swift
//  Mac_Health
//
//  Created by 정회승 on 11/16/23.
//

import SwiftUI

struct RecordingFinishView: View {
    
    @State var tabSelection: Int = 3
    var body: some View {
        ZStack{
            Color.gray_900.ignoresSafeArea()
            VStack {
                Rectangle()
                    .frame(width: 276, height: 152)
                Image(systemName: "person")
                    .resizable()
                    .frame(width: 150, height: 128)
                RoundedRectangle(cornerRadius: 8.0)
                    .frame(width: UIScreen.getWidth(294), height: UIScreen.getHeight(100))
                    .foregroundColor(.gray_700)
                    .overlay{
                        VStack(spacing: 5){
                            Text("23.11.08")
                                .font(.title1())
                                .foregroundColor(.label_900)
                            Text("오늘도 고생 많으셨어요!")
                                .font(.body())
                                .foregroundColor(.label_900)
                        }
                    }
                HStack(spacing: 40){
                    VStack(spacing: 3){
                        Text("45분")
                            .font(.title2())
                            .foregroundColor(.label_900)
                        Text("운동시간")
                            .font(.body2())
                            .foregroundColor(.label_700)
                    }
                    VStack(spacing: 3){
                        Text("632kcal")
                            .font(.title2())
                            .foregroundColor(.label_900)
                        Text("소모칼로리")
                            .font(.body2())
                            .foregroundColor(.label_700)
                    }
                    VStack(spacing: 3){
                        Text("6300kg")
                            .font(.title2())
                            .foregroundColor(.label_900)
                        Text("총 볼륨")
                            .font(.body2())
                            .foregroundColor(.label_700)
                    }
                }
                .padding()
                Spacer()
                    .frame(height: 100)
                Button{
                    tabSelection = 3
                    print(self.tabSelection)
                } label: {
                    FloatingButton(backgroundColor: .green_main) { Text("기록 확인")
                            .foregroundColor(.gray_900)
                            .font(.button1())
                    }
                    .padding(.bottom, 5)
                    
                }
                
                Button{
                    
                } label: {
                    FloatingButton(backgroundColor: .gray_600) { Text("닫기")
                            .foregroundColor(.green_main)
                            .font(.button1())
                }
                
                }
            }
        }
        .navigationBarBackButtonHidden()
        .ignoresSafeArea()

    }
}

#Preview {
    RecordingFinishView()
}
