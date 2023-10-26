//
//  FloatingButton.swift
//  Mac_Health
//
//  Created by 송재훈 on 10/24/23.
//

import SwiftUI

struct FloatingButton<Content: View>: View {
    let backgroundColor: Color
    @ViewBuilder let content: Content
    
    var body: some View {
        RoundedRectangle(cornerRadius: 100)
            .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(60))
            .foregroundColor(backgroundColor)
            .overlay {
                content
            }
    }
}

struct FloatingButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            //루틴 둘러보기
            FloatingButton(backgroundColor: .green_main) { Text("루틴 둘러보기")
                    .foregroundColor(.gray_900)
                    .font(.button1())
            }
            
            //green 둘러보기
            FloatingButton(backgroundColor: .gray_600) { Text("둘러보기")
                    .foregroundColor(.green_main)
                    .font(.button1())
            }
            
            //red 운동 완료하기
            FloatingButton(backgroundColor: .gray_600) { Text("운동 완료하기")
                    .foregroundColor(.red_main)
                    .font(.button1())
            }
            
            //세트완료 플로팅 버튼
            FloatingButton(backgroundColor: .gray_600) {
                HStack {
                    Button{
                        print("list up")
                    }label: {
                        Image(systemName: "list.bullet")
                            .foregroundColor(.label_900)
                            .font(.title2)
                    }
                    .padding(.horizontal)
                    Spacer()
                    Button {
                        print("pause")
                    } label: {
                        Capsule()
                            .foregroundColor(.green_main)
                            .frame(width: UIScreen.getWidth(120), height: UIScreen.getHeight(48))
                            .overlay{
                                Text("세트완료")
                                    .foregroundColor(.gray_900)
                                    .font(.button1())
                            }
                    }
                }
                .padding(.leading, 15)
                .padding(.trailing, 6)
            }
            
            //세트완료 플로팅 버튼
            FloatingButton(backgroundColor: .gray_600) {
                HStack {
                    Button{
                        print("list up")
                    }label: {
                        Image(systemName: "list.bullet")
                            .foregroundColor(.label_900)
                            .font(.title2)
                    }
                    .padding(.horizontal)
                    Spacer()
                    Button {
                        print("pause")
                    } label: {
                        Capsule()
                            .foregroundColor(.green_main)
                            .frame(width: UIScreen.getWidth(120), height: UIScreen.getHeight(48))
                            .overlay{
                                Text("세트완료")
                                    .foregroundColor(.gray_900)
                                    .font(.button1())
                            }
                    }
                }
                .padding(.leading, 15)
                .padding(.trailing, 6)
            }
            
            //운동 종류 타이머
            FloatingButton(backgroundColor: .green_main) {
                HStack {
                    VStack(alignment: .leading){
                        Text("클로즈 그립 랫 풀 다운")
                            .foregroundColor(.gray_900)
                            .font(.headline2())
                        //타이머
                        Text("00:00:15")
                            .font(.headline2())
                            .foregroundColor(.black)
                            .opacity(0.4)
                    }
                    .padding(.horizontal)
                    Spacer()
                    Button {
                        print("pause")
                    } label: {
                        Image(systemName: "pause.fill")
                            .foregroundColor(.black)
                    }
                    Button {
                        print("stop")
                    } label: {
                        Image(systemName: "stop.fill")
                            .foregroundColor(.black)
                    }
                    .padding(.horizontal, 15)
                }
                .padding(.horizontal)
            }
        }
    }
}
