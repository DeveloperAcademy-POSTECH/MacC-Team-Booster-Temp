//
//  RoutinePreview.swift
//  Mac_Health
//
//  Created by 정회승 on 2023/10/21.
//

import SwiftUI

struct RoutinePreview: View {
    //날짜 변환
    var date:String = "2023년 10월 15일"
    var part:String = "등/가슴"
    var firstPart = "등"
    var secondPart = "가슴"
    var body: some View {
        ZStack{
            Color.gray_900.ignoresSafeArea()
            VStack {
                HStack{
                VStack(alignment: .leading){
                    Text("루틴 미리보기")
                        .font(.title2)
                        .foregroundColor(.label_900)
                    HStack{
                        Text(date)
                            .font(.headline2())
                            .foregroundColor(.label_700)
                        Rectangle()
                            .frame(width:1, height: 10)
                            .foregroundColor(.label_400)
                        Text(part)
                            .font(.headline2())
                            .foregroundColor(.label_700)
                        
                    }
                }
                .padding(20)
                    Spacer()
                }
                HStack{
                    Text(firstPart)
                        .font(.headline1())
                        .foregroundColor(.label_900)
                        .padding(20)
                    Spacer()
                }
                
                
            }
            
        }
    }
}

struct RoutinePreview_Previews: PreviewProvider {
    static var previews: some View {
        RoutinePreview()
    }
}
