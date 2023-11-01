//
//  TodayRoutineView.swift
//  Mac_Health
//
//  Created by 정회승 on 2023/11/01.
//

import SwiftUI

struct TodayRoutineView: View {
    var todayText = "오늘은 컨디션이 좀 안 좋아서 살살 했어요"
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
                Image(systemName: "person")
                    .resizable()
                    .scaledToFit()
            }
            HStack(alignment: .top){
                VStack(alignment: .leading){
                    Text(todayText)
                        .font(.body)
                        .foregroundColor(.label_800)
                }
            }
            .frame(width: UIScreen.getWidth(350))
            .padding(.vertical, 20)
                .background{
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(.gray_700)
                }

            ZStack{
                VStack{
                    HStack{
                        Text("11월 1일 수요일")
                            .font(.title2())
                            .foregroundColor(.label_900)
                        Spacer()
                        Image(systemName: "calendar")
                            .font(.title2())
                            .foregroundColor(.green_main)
                    }
                    .padding(20)
                    VStack{
                        ForEach(TodaySpecificViewModel.allCases, id: \.self) { option in
                            HStack{
                                VStack{
                                    Image(systemName: option.image)
                                        .font(.body())
                                        .foregroundColor(.label_700)
                                        .padding(.leading, 15)
                                }
                                VStack{
                                    Text(option.contents)
                                        .font(.body())
                                        .foregroundColor(.label_900)
                                }
                                Spacer()
                            }
                            .padding(5)
                        }
                    }
                    Spacer()
                    //운동 시작 버튼
                    RoundedRectangle(cornerRadius: 100)
                        .frame(width: UIScreen.getWidth(318), height: UIScreen.getHeight(60))
                        .foregroundColor(.green_main)
                        .overlay { Text("운동 시작")
                                .foregroundColor(.gray_900)
                                .font(.button1())
                        }.padding(.bottom, 10)
                }
            }
            .frame(width: UIScreen.getWidth(350))
            .padding(.vertical, 10)
                .background{
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(.gray_700)
                }
        }
        
    }
}

struct TodayRoutineView_Previews: PreviewProvider {
    static var previews: some View {
        TodayRoutineView()
    }
}
