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
    let previewRoutine: PreviewRoutine
    
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
                //운동 루틴
                WorkoutExplain
                //첫 운동 팁 설명
//                ZStack{
                    HStack(alignment: .top){
                        Image("descriptionFace1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.getWidth(48))
                            .padding(10)
                    VStack(alignment: .leading){
                        Text("운동 팁 예시")
                            .font(.body2())
                            .foregroundColor(.label_500)
                            .padding(.bottom, 5)
                        
                        Text(previewRoutine.exerciseTip!)
                            .font(.body)
                            .foregroundColor(.label_900)
                    }
                    .padding(.vertical, 10)
                }
                    .padding(10)
                    .background{
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(.gray_700)
                        
                    }
                    .padding(20)

//                }
                WorkoutExplain
                //부위별 다른지 체크
                HStack{
                    Text(secondPart)
                        .font(.headline1())
                        .foregroundColor(.label_900)
                        .padding(20)
                    Spacer()
                }
                WorkoutExplain
                WorkoutExplain
                
            }
            .padding(.bottom, 30)
            VStack{
                Spacer()
                Image("previewGradient")
                    .resizable()
                    .scaledToFit()
            }
        }
        
    }
    
    @ViewBuilder
    var WorkoutExplain: some View {
        HStack{
            Image("CloseGripLatPullDown")
                .resizable()
                .frame(width: UIScreen.getWidth(64), height: UIScreen.getHeight(64))
                .padding(.leading, 20)
            VStack(alignment: .leading){
                Text("클로즈 그립 랫 풀 다운")
                    .font(.headline1())
                    .foregroundColor(.label_900)
                HStack{
                    Text("3세트")
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
            .padding(.leading, 10)

            Spacer()
        }
    }
}

struct RoutinePreview_Previews: PreviewProvider {
    static var previews: some View {
        RoutinePreview(previewRoutine: previewRoutine[0])
    }
}
