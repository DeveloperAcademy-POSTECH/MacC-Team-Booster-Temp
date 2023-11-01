//
//  TodayRoutineView.swift
//  Mac_Health
//
//  Created by 정회승 on 2023/11/01.
//

import SwiftUI

struct TodayRoutineView: View {
    var Influencer = "정회승"
    var body: some View {
        VStack{
            ZStack(alignment: .top) {
                HStack{
                    Text("\(Influencer)의 \n오늘의 루틴")
                        .font(.title1())
                        .foregroundColor(.label_900)
                        .padding(.leading, 20)
                    Spacer()
                }
                Image("Influencer1")
                    .resizable()
                    .scaledToFit()
            }
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(.gray_700)
                .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(54))
            ZStack{
                
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(.gray_700)
                    .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(325))
                
                VStack{
                    HStack{
                        Text("11월 1일 수요일")
                        Image(systemName: "calendar")
                    }
                    Text("11월 1일 수요일")
                    Spacer()
                    //운동 시작 버튼
                    RoundedRectangle(cornerRadius: 100)
                        .frame(width: UIScreen.getWidth(318), height: UIScreen.getHeight(60))
                        .foregroundColor(.green_main)
                        .overlay { Text("운동 시작")
                                .foregroundColor(.gray_900)
                                .font(.button1())
                        }.padding(.bottom, 30)
                }
            }
        }
        
    }
}

struct TodayRoutineView_Previews: PreviewProvider {
    static var previews: some View {
        TodayRoutineView()
    }
}
